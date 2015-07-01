From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Wed, 01 Jul 2015 09:40:58 +0000
Subject: [PATCH v2 03/12] string: Introduce strends()
Message-Id: <1435743667-11987-4-git-send-email-tomeu.vizoso@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org

To avoid duplicating code in upcoming patches that will check for
postfixes in strings, add strends().

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2:
- Move strends to string.h

 include/linux/string.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index d5dfe3e..4244363 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -146,6 +146,19 @@ static inline bool strstarts(const char *str, const char *prefix)
 	return strncmp(str, prefix, strlen(prefix)) = 0;
 }
 
+/**
+ * strends - does @str end with @postfix?
+ * @str: string to examine
+ * @postfix: postfix to look for
+ */
+static inline bool strends(const char *str, const char *postfix)
+{
+	if (strlen(str) < strlen(postfix))
+		return false;
+
+	return strcmp(str + strlen(str) - strlen(postfix), postfix) = 0;
+}
+
 size_t memweight(const void *ptr, size_t bytes);
 void memzero_explicit(void *s, size_t count);
 
-- 
2.4.1

