From: Juston Li <juston.h.li@gmail.com>
Date: Sat, 20 Jun 2015 18:36:51 +0000
Subject: [PATCH 17/19] staging: sm750fb: move while to follow do close brace
Message-Id: <1434825413-4994-17-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
In-Reply-To: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

fixes checkpatch.pl error:
ERROR: while should follow close brace '}'

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index bd2be7f..90c5c9e 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -139,16 +139,14 @@ static void waitNextVerticalSync(int ctrl, int delay)
 				status = FIELD_GET(PEEK32(SYSTEM_CTRL),
 						   SYSTEM_CTRL,
 						   PANEL_VSYNC);
-			}
-			while (status = SYSTEM_CTRL_PANEL_VSYNC_ACTIVE);
+			} while (status = SYSTEM_CTRL_PANEL_VSYNC_ACTIVE);
 
 			/* Wait for start of vsync. */
 			do {
 				status = FIELD_GET(PEEK32(SYSTEM_CTRL),
 						   SYSTEM_CTRL,
 						   PANEL_VSYNC);
-			}
-			while (status = SYSTEM_CTRL_PANEL_VSYNC_INACTIVE);
+			} while (status = SYSTEM_CTRL_PANEL_VSYNC_INACTIVE);
 		}
 
 	} else {
@@ -168,16 +166,14 @@ static void waitNextVerticalSync(int ctrl, int delay)
 				status = FIELD_GET(PEEK32(SYSTEM_CTRL),
 								   SYSTEM_CTRL,
 								   CRT_VSYNC);
-			}
-			while (status = SYSTEM_CTRL_CRT_VSYNC_ACTIVE);
+			} while (status = SYSTEM_CTRL_CRT_VSYNC_ACTIVE);
 
 			/* Wait for start of vsync. */
 			do {
 				status = FIELD_GET(PEEK32(SYSTEM_CTRL),
 								   SYSTEM_CTRL,
 								   CRT_VSYNC);
-			}
-			while (status = SYSTEM_CTRL_CRT_VSYNC_INACTIVE);
+			} while (status = SYSTEM_CTRL_CRT_VSYNC_INACTIVE);
 		}
 	}
 }
-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
