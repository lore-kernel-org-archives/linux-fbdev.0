From: Takashi Yoshii <yoshii.takashi@renesas.com>
Subject: Re: [PATCH] Do set var even if no
 fb_check_var() provided.
Date: Thu, 04 Sep 2008 16:38:20 +0900
Message-ID: <48BF906C.4020904@renesas.com>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin>
	<48B759B0.4010001@renesas.com>
	<Pine.LNX.4.64.0808290902190.22326@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kb9QN-0001M2-4g for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 00:38:39 -0700
Received: from mail.renesas.com ([202.234.163.13] helo=mail01.idc.renesas.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kb9QM-00004t-MT
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 00:38:39 -0700
In-reply-to: <Pine.LNX.4.64.0808290902190.22326@anakin>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Geert Uytterhoeven wrote:
> Panning state is not unknown. It's in var.
I don't think it is not always in var.
I found there are following three types of drivers.

1. ideal(?) driver
FBIOPUT_VSCREENINFO: pan (rounded a_set_varnd) done, no error, pan in returned var
FBIOGET_VSCREENINFO: returns pan

2. driver which doesn't provide own check_var (fixed mode drivers)
FBIOPUT_VSCREENINFO: no pan done, no error, false pan in returned var
FBIOGET_VSCREENINFO: returns pan

3. driver which doesn't provede pan_display nor check pan in check_var
FBIOPUT_VSCREENINFO: no pan done, no error, false pan in returned var
FBIOGET_VSCREENINFO: returns false pan

2 will be trouble if people expect they can initialize pan by
FBIOPUT_VSCREENINFO. Actually, you need FBIOPAN_DISPLAY afterwards.
Or when they believe returned var have valid value for pan.
Actually, you need FBIOGET_VSCREENINFO (anyway, you need FBIOPAN_DISPLAY as
 described above, this one is not so big problem).

3 is weired. info->var continuously have value which can not be set to HW.
Many drivers which doesn't support pan seems to be this type
(sstfb is one of exceptions).
Possibly, we can fix it at the middle of fb_set_var().
But because of the rule(?) that only *_check_var() can freely modify var, 
In this case, *_check_var() in each driver should do return error, or set
 them 0. Right?

> If you don't know the pixclock, set it to 0.
OK. Thank you.
/yoshii


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
