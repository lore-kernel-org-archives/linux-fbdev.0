From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 14 Nov 2014 11:03:13 +0000
Subject: [PATCH v5 2/5] of.h: Keep extern declaration of of_* variables when !CONFIG_OF
Message-Id: <1415962996-31712-2-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415962996-31712-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415962996-31712-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Keep the extern declaration of of_allnodes and friends, when building without
of support, this way code using them can be written like this:

	if (IS_ENABLED(CONFIG_OF_PLATFORM) && of_chosen) {
		for_each_child_of_node(of_chosen, np)
			...
	}

And rely on the compiler optimizing it away, avoiding the need for #ifdef-ery.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/linux/of.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 6545e7a..f83ca9d 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -105,8 +105,6 @@ static inline struct device_node *of_node_get(struct device_node *node)
 static inline void of_node_put(struct device_node *node) { }
 #endif /* !CONFIG_OF_DYNAMIC */
 
-#ifdef CONFIG_OF
-
 /* Pointer for first entry in chain of all nodes. */
 extern struct device_node *of_allnodes;
 extern struct device_node *of_chosen;
@@ -114,6 +112,7 @@ extern struct device_node *of_aliases;
 extern struct device_node *of_stdout;
 extern raw_spinlock_t devtree_lock;
 
+#ifdef CONFIG_OF
 static inline bool of_have_populated_dt(void)
 {
 	return of_allnodes != NULL;
-- 
2.1.0

