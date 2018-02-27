From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 00:04:19 +0000
Subject: [PATCH 2/3] console: Fill in struct consw argument names
Message-Id: <1519689860-7421-3-git-send-email-keescook@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1519689860-7421-1-git-send-email-keescook@chromium.org>
In-Reply-To: <1519689860-7421-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Winischhofer <thomas@winischhofer.net>, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Reading the function declarations for the console callbacks lacks any
hints as to what the arguments are. Instead of going and digging around in
various implementations that may each only have a subset of the callbacks,
name all the arguments in the declaration. This has no functional change.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/console.h | 58 +++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index b8920a031a3e..dfd6b0e97855 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -46,46 +46,52 @@ enum con_scroll {
 struct consw {
 	struct module *owner;
 	const char *(*con_startup)(void);
-	void	(*con_init)(struct vc_data *, int);
-	void	(*con_deinit)(struct vc_data *);
-	void	(*con_clear)(struct vc_data *, int, int, int, int);
-	void	(*con_putc)(struct vc_data *, int, int, int);
-	void	(*con_putcs)(struct vc_data *, const unsigned short *, int, int, int);
-	void	(*con_cursor)(struct vc_data *, int);
-	bool	(*con_scroll)(struct vc_data *, unsigned int top,
+	void	(*con_init)(struct vc_data *vc, int init);
+	void	(*con_deinit)(struct vc_data *vc);
+	void	(*con_clear)(struct vc_data *vc, int sy, int sx, int height,
+			int width);
+	void	(*con_putc)(struct vc_data *vc, int c, int ypos, int xpos);
+	void	(*con_putcs)(struct vc_data *vc, const unsigned short *s,
+			int count, int ypos, int xpos);
+	void	(*con_cursor)(struct vc_data *vc, int mode);
+	bool	(*con_scroll)(struct vc_data *vc, unsigned int top,
 			unsigned int bottom, enum con_scroll dir,
 			unsigned int lines);
-	int	(*con_switch)(struct vc_data *);
-	int	(*con_blank)(struct vc_data *, int, int);
-	int	(*con_font_set)(struct vc_data *, struct console_font *, unsigned);
-	int	(*con_font_get)(struct vc_data *, struct console_font *);
-	int	(*con_font_default)(struct vc_data *, struct console_font *, char *);
-	int	(*con_font_copy)(struct vc_data *, int);
-	int     (*con_resize)(struct vc_data *, unsigned int, unsigned int,
-			       unsigned int);
-	void	(*con_set_palette)(struct vc_data *,
+	int	(*con_switch)(struct vc_data *vc);
+	int	(*con_blank)(struct vc_data *vc, int blank, int mode_switch);
+	int	(*con_font_set)(struct vc_data *vc, struct console_font *font,
+			unsigned int flags);
+	int	(*con_font_get)(struct vc_data *vc, struct console_font *font);
+	int	(*con_font_default)(struct vc_data *vc,
+			struct console_font *font, char *name);
+	int	(*con_font_copy)(struct vc_data *vc, int con);
+	int     (*con_resize)(struct vc_data *vc, unsigned int width,
+			unsigned int height, unsigned int user);
+	void	(*con_set_palette)(struct vc_data *vc,
 			const unsigned char *table);
-	void	(*con_scrolldelta)(struct vc_data *, int lines);
-	int	(*con_set_origin)(struct vc_data *);
-	void	(*con_save_screen)(struct vc_data *);
-	u8	(*con_build_attr)(struct vc_data *, u8, u8, u8, u8, u8, u8);
-	void	(*con_invert_region)(struct vc_data *, u16 *, int);
-	u16    *(*con_screen_pos)(struct vc_data *, int);
-	unsigned long (*con_getxy)(struct vc_data *, unsigned long, int *, int *);
+	void	(*con_scrolldelta)(struct vc_data *vc, int lines);
+	int	(*con_set_origin)(struct vc_data *vc);
+	void	(*con_save_screen)(struct vc_data *vc);
+	u8	(*con_build_attr)(struct vc_data *vc, u8 color, u8 intensity,
+			u8 blink, u8 underline, u8 reverse, u8 italic);
+	void	(*con_invert_region)(struct vc_data *vc, u16 *p, int count);
+	u16    *(*con_screen_pos)(struct vc_data *vc, int offset);
+	unsigned long (*con_getxy)(struct vc_data *vc, unsigned long position,
+			int *px, int *py);
 	/*
 	 * Flush the video console driver's scrollback buffer
 	 */
-	void	(*con_flush_scrollback)(struct vc_data *);
+	void	(*con_flush_scrollback)(struct vc_data *vc);
 	/*
 	 * Prepare the console for the debugger.  This includes, but is not
 	 * limited to, unblanking the console, loading an appropriate
 	 * palette, and allowing debugger generated output.
 	 */
-	int	(*con_debug_enter)(struct vc_data *);
+	int	(*con_debug_enter)(struct vc_data *vc);
 	/*
 	 * Restore the console to its pre-debug state as closely as possible.
 	 */
-	int	(*con_debug_leave)(struct vc_data *);
+	int	(*con_debug_leave)(struct vc_data *vc);
 };
 
 extern const struct consw *conswitchp;
-- 
2.7.4

