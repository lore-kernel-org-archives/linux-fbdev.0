From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Mon, 28 Mar 2011 14:38:39 +0000
Subject: vt & fbcon changes
Message-Id: <20110328163839.16e66a6f@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi James,

How is your refactoring of vt (and fbcon) progressing?

Last commit visible in your GIT tree [1] dates back to last November...

I'm looking at resuming my ref-counted framebuffer work though would
like to avoid duplicate work with your vt changes (and/or big merging
conflicts).

From first glance registered_fb[] is the biggest source of conflict,
in your patches you are dropping (most) of its use as you kill con2fb_map[]
in fbcon.c -- on my side I am planning to convert con2fb_map from char
to struct fb_info*

Thanks,
Bruno


[1] http://git.infradead.org/users/jsimmons/linuxconsole-2.6.git
