From: Takashi Yoshii <yoshii.takashi@renesas.com>
Subject: Re: [PATCH] Add fb_check_var() for fixed mode
 device.
Date: Fri, 29 Aug 2008 16:48:26 +0900
Message-ID: <48B7A9CA.1010609@renesas.com>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin> <g94i4r$2hq$1@ger.gmane.org>
	<20080828074521.GO16680@sci.fi> <48B785DA.1030408@renesas.com>
	<1219993633.4421.248.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYyip-0003O2-Hz for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 00:48:43 -0700
Received: from mail.renesas.com ([202.234.163.13] helo=mail04.idc.renesas.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYyio-0002yx-3m
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 00:48:43 -0700
In-reply-to: <1219993633.4421.248.camel@thor.sulgenrain.local>
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
To: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel@tungstengraphics.com>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net

> What 'Xorg issue'? I've only seen a misconfiguration and a pixclock 0
> issue which has been fixed in Xorg.
pixclock 0 one. Which has beed fixed in git. But I don't expect all people
 do/can build latest Xorg source. And there might be people who think modifying
 kernel is easier, especially because this is kernel related ML.
/yoshii

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
