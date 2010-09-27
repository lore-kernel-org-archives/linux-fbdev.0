From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Mon, 27 Sep 2010 20:23:51 +0000
Subject: fbcon: fbcon_fb_unbind() mixing up vc/fb indexes?
Message-Id: <20100927222351.1e15e2fd@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi James,

What's your opinion regarding the code I marked in below quoted
fbcon.c snipplet?

This looks wrong, setting 'new_idx' to 'i', I would rather see it set to
con2fb_map[i] instead as it's used as index into registered_fb[] by
set_con2fb_map(), 'i' itself being used as vc index!

Bruno



drivers/video/console/fbcon.c:
2991 static int fbcon_fb_unbind(int idx)
2992 {
2993         int i, new_idx = -1, ret = 0;
2994
2995         if (!fbcon_has_console_bind)
2996                 return 0;
2997
2998         for (i = first_fb_vc; i <= last_fb_vc; i++) {
2999                 if (con2fb_map[i] != idx &&
3000                     con2fb_map[i] != -1) {
3001                         new_idx = i;
                             ^^^^^^^^^^^
3002                         break;
3003                 }
3004         }
3005
3006         if (new_idx != -1) {
3007                 for (i = first_fb_vc; i <= last_fb_vc; i++) {
3008                         if (con2fb_map[i] = idx)
3009                                 set_con2fb_map(i, new_idx, 0);
                                                       ^^^^^^^
3010                 }
3011         } else
3012                 ret = fbcon_unbind();
3013
3014         return ret;
3015 }
