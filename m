From: Randy Dunlap <rdunlap@infradead.org>
Date: Sat, 14 Mar 2020 07:35:17 +0000
Subject: pm3fb.c: question
Message-Id: <9f7b3b9b-f48e-6da1-d08c-cc60f60b1eac@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

In drivers/video/fbdev/pm3fb.c, if I change the definition of DPRINTK()
(in order to remove some gcc warnings if -Wextra is used), like this:

-#define DPRINTK(a, b...)
+#define DPRINTK(a, b...)	no_printk(a, ##b)

I get a build error here:
		default:
			DPRINTK("Unsupported depth %d\n",
				info->current_par->depth);
			break;

../drivers/video/fbdev/pm3fb.c: In function ‘pm3fb_init_engine’:
../drivers/video/fbdev/pm3fb.c:353:9: error: ‘struct fb_info’ has no member named ‘current_par’
     info->current_par->depth);
         ^

Is there a replacement (fix) for this field?
or should the entire DPRINTK() be deleted?
or somethine else?

thanks.
-- 
~Randy
