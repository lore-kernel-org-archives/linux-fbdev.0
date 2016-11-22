From: Andrey Utkin <andrey_utkin@fastmail.com>
Date: Tue, 22 Nov 2016 19:31:43 +0000
Subject: Re: [PATCH v6 2/2] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20161122193143.GG11418@dell-m4800.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479832909-19646-1-git-send-email-manuel.schoelling@gmx.de>
 <1479832909-19646-3-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1479832909-19646-3-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Well done Manuel.

I'm not sure my emails with review of previous submission reached you, but in
them I meant to mention that there are some style nits which are easy to
eliminate.

checkpatch --strict is happy on patch 1/2, but on 2/2 there are few points. If
you ever have a reason to submit v7, please make sure to pick these points,
too. Except for the last one, which seems reasonable case to violate the rule
in my personal opinion.

 $ ./scripts/checkpatch.pl --strict ~/console2.patch 
CHECK: Please use a blank line after function/struct/union/enum declarations
#155: FILE: drivers/video/console/vgacon.c:175:
+};
+static struct vgacon_scrollback_info *vgacon_scrollback_cur;

CHECK: spaces preferred around that '/' (ctx:VxV)
#185: FILE: drivers/video/console/vgacon.c:196:
+	int rows = size/pitch;
 	               ^

CHECK: Alignment should match open parenthesis
#189: FILE: drivers/video/console/vgacon.c:200:
+	data = kmalloc_array(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE, 1024,
+		GFP_NOWAIT);

CHECK: braces {} should be used on all arms of this statement
#206: FILE: drivers/video/console/vgacon.c:217:
+	if (!vgacon_scrollbacks[vc_num].data)
[...]
+	else {
[...]

CHECK: Logical continuations should be on the previous line
#234: FILE: drivers/video/console/vgacon.c:241:
+	if (!vgacon_scrollback_cur->data || !vgacon_scrollback_cur->size
+	    || c->vc_num != fg_console)

WARNING: line over 80 characters
#259: FILE: drivers/video/console/vgacon.c:259:
+			vgacon_scrollback_cur->cnt = vgacon_scrollback_cur->rows;

total: 0 errors, 1 warnings, 5 checks, 258 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/j/console2.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



P. S. Manuel, please fix your git-send-email workflow or apply some
workaround (check locale settings and such). Again your References
header contains illegal symbol:

References: <201611210615.PPE1zXiO??ngguang.wu@intel.com>
