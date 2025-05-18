const rl = @import("raylib");

const GameScreen = enum {
    logo,
    title,
    gameplay,
    ending,
};

pub fn main() !void {
    const screen_width: i32 = 800;
    const screen_height: i32 = 450;

    rl.initWindow(screen_width, screen_height, "learn-raylib - basic screen manager");
    defer rl.closeWindow();

    var currentScreen: GameScreen = .logo;

    var frames_counter: i32 = 0;

    rl.setTargetFPS(60);

    // Main game loop
    while (!rl.windowShouldClose()) {
        // Update
        switch (currentScreen) {
            .logo => {
                frames_counter += 1;

                // Wait for 2 seconds (120 frames) before jumping to `title` screen
                if (frames_counter > 120)
                    currentScreen = .title;
            },
            .title => {
                // Press ENTER to change to `gameplay` screen
                if (rl.isKeyPressed(.enter) or rl.isGestureDetected(.tap))
                    currentScreen = .gameplay;
            },
            .gameplay => {
                // Press ENTER to change to `ending` screen
                if (rl.isKeyPressed(.enter) or rl.isGestureDetected(.tap))
                    currentScreen = .ending;
            },
            .ending => {
                // Press ENTER to change to `title` screen
                if (rl.isKeyPressed(.enter) or rl.isGestureDetected(.tap))
                    currentScreen = .title;
            },
        }

        // Draw
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.ray_white);

        switch (currentScreen) {
            .logo => {
                rl.drawText("LOGO SCREEN", 20, 20, 40, .light_gray);
                rl.drawText("WAIT for 2 SECONDS...", 290, 220, 20, .gray);
            },
            .title => {
                rl.drawRectangle(0, 0, screen_width, screen_height, .green);
                rl.drawText("TITLE SCREEN", 20, 20, 40, .dark_green);
                rl.drawText("PRESS ENTER or TAP to JUMP to GAMEPLAY SCREEN", 120, 220, 20, .dark_green);
            },
            .gameplay => {
                rl.drawRectangle(0, 0, screen_width, screen_height, .purple);
                rl.drawText("GAMEPLAY SCREEN", 20, 20, 40, .maroon);
                rl.drawText("PRESS ENTER or TAP to JUMP to ENDING SCREEN", 120, 220, 20, .maroon);
            },
            .ending => {
                rl.drawRectangle(0, 0, screen_width, screen_height, .blue);
                rl.drawText("ENDING SCREEN", 20, 20, 40, .dark_blue);
                rl.drawText("PRESS ENTER or TAP to JUMP to TITLE SCREEN", 120, 220, 20, .dark_blue);
            },
        }
    }
}
