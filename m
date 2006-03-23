From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Linux 2.6.16: Cursor trouble on Matrox Millenium
 II framebuffer
Date: Thu, 23 Mar 2006 21:10:01 +0800
Message-ID: <44229E29.8020201@gmail.com>
References: <4421DCD7.6010908@gmail.com>	 <20060323004734.31741.qmail@web52911.mail.yahoo.com> <21d7e9970603230309h5e74bfbajc3f07efd6c41bac3@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMYPB-0005MO-Nw
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 14:35:45 -0800
Received: from pproxy.gmail.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMYPB-0007IF-JE
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 14:35:45 -0800
Received: by pproxy.gmail.com with SMTP id z59so516396pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 14:35:44 -0800 (PST)
In-Reply-To: <21d7e9970603230309h5e74bfbajc3f07efd6c41bac3@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, vandrove@vc.cvut.cz

Dave Airlie wrote:
> On 3/23/06, Chris Rankin <rankincj@yahoo.com> wrote:
>> Hmm, the effect is no longer happening on my console, although it was at a consistent height
>> before. (As if someone thought that the framebuffer had fewer lines than it actually did.)
>>
> 
> Happens for me with my intelfb tree, on first entry to fbcon.. a VT
> switch fixes it...

Hmm, I cannot duplicate this, but I haven't tried 2.6.16 yet, as I almost always
boot to an mm kernel. And that I use a relatively old distrib (Suse 9.0) may be a
factor. I'll check if I can duplicate this with 2.6.16, and with a machine at work
with Suse 10.0.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
