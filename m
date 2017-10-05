From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 05 Oct 2017 01:25:51 +0000
Subject: [RFC PATCH] clk: move of_clk_get_parent_count() declaration to <linux/__clk.h>
Message-Id: <1507166751-2012-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-fbdev@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Russell King <linux@armlinux.org.uk>

The clock consumer, drivers/video/fbdev/simplefb.c, includes
<linux/clk-provider.h> just for calling of_clk_get_parent_count().
This is ugly.

Looking at simplefb_clocks_get(), of_clk_get_parent_count() seems
useful for clock consumers as well as for clock providers.

Unfortunately, we do not have a good home for declarations shared
between consumers and providers.

Create a new header <linux/__clk.h>, and move it over to it.  This
header must be included via <linux/clk.h> or <linux/clk-provider.h>
(this is why it is prefixed with double-underscore).  Add #error
so the build terminates if it is included directly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/video/fbdev/simplefb.c |  1 -
 include/linux/__clk.h          | 31 +++++++++++++++++++++++++++++++
 include/linux/clk-provider.h   |  7 ++-----
 include/linux/clk.h            |  2 ++
 4 files changed, 35 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/__clk.h

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index a3c44ec..17f0aec 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -27,7 +27,6 @@
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-#include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/parser.h>
diff --git a/include/linux/__clk.h b/include/linux/__clk.h
new file mode 100644
index 0000000..a8b86bf
--- /dev/null
+++ b/include/linux/__clk.h
@@ -0,0 +1,31 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX___CLK_H
+#define __LINUX___CLK_H
+
+/* This header contains stuff shared between consumers and providers. */
+
+#if !defined(__LINUX_CLK_H) && !defined(__LINUX_CLK_PROVIDER_H)
+#error "Please don't include <linux/__clk.h> directly, include <linux/clk.h> or <linux/clk-provider.h> instead."
+#endif
+
+struct device_node;
+
+#if defined(CONFIG_COMMON_CLK) && defined(CONFIG_OF)
+
+unsigned int of_clk_get_parent_count(struct device_node *np);
+
+#else
+
+static inline unsigned int of_clk_get_parent_count(struct device_node *np)
+{
+	return 0;
+}
+
+#endif
+
+#endif /* __LINUX___CLK_H */
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5100ec1..cd9bca1 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -14,6 +14,8 @@
 #include <linux/io.h>
 #include <linux/of.h>
 
+#include "__clk.h"
+
 #ifdef CONFIG_COMMON_CLK
 
 /*
@@ -823,7 +825,6 @@ struct clk_hw *of_clk_hw_simple_get(struct of_phandle_args *clkspec,
 struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data);
 struct clk_hw *of_clk_hw_onecell_get(struct of_phandle_args *clkspec,
 				     void *data);
-unsigned int of_clk_get_parent_count(struct device_node *np);
 int of_clk_parent_fill(struct device_node *np, const char **parents,
 		       unsigned int size);
 const char *of_clk_get_parent_name(struct device_node *np, int index);
@@ -868,10 +869,6 @@ of_clk_hw_onecell_get(struct of_phandle_args *clkspec, void *data)
 {
 	return ERR_PTR(-ENOENT);
 }
-static inline unsigned int of_clk_get_parent_count(struct device_node *np)
-{
-	return 0;
-}
 static inline int of_clk_parent_fill(struct device_node *np,
 				     const char **parents, unsigned int size)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 12c96d9..83d24cb 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -16,6 +16,8 @@
 #include <linux/kernel.h>
 #include <linux/notifier.h>
 
+#include "__clk.h"
+
 struct device;
 struct clk;
 struct device_node;
-- 
2.7.4

