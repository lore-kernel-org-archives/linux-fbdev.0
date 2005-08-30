From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: fbset : strange problem (fwd)
Date: Tue, 30 Aug 2005 09:19:00 +0800
Message-ID: <4313B404.3020002@gmail.com>
References: <Pine.LNX.4.62.0508282156190.27014@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E9uma-0007r8-2z
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Aug 2005 18:19:24 -0700
Received: from wproxy.gmail.com ([64.233.184.199])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E9umZ-0003Em-OQ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Aug 2005 18:19:24 -0700
Received: by wproxy.gmail.com with SMTP id i3so468021wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 29 Aug 2005 18:19:14 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0508282156190.27014@numbat.sonytel.be>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: p.pouget@nerim.net, Geert Uytterhoeven <geert@linux-m68k.org>

Geert Uytterhoeven wrote:
> ---------- Forwarded message ----------
> Date: Sun, 28 Aug 2005 21:27:58 +0200 (CEST)
> From: p.pouget@nerim.net
> To: geert.uytterhoeven@cs.kuleuven.ac.be, geert.uijtterhoeven@cs.kuleuven.ac.be
> Cc: p.pouget@nerim.net
> Subject: fbset : strange problem
> 
> Hello
> 
> I am trying to use the frame buffers under linux 2.6.12.xxx.
> 
> fbset should work via the drivers then as the same way regardless the
> hardware it runs on?
> 
> On my dell inspiron using a radeon mobility, everything works well, fbset
> sets, consfb works etc... vlc uses the frame buffer etc...
> 
> On my Tyan S2885, I have problems with 2 radeons:
> On the 0x4966 ( R250 ) fbset looks like to change the resolution but I see
> the bios startup screen splitted. The machine is running properly but
> without screen
> On the 0x554f ( R423 according FB R430 according xorg ) bfset makes an
> ooops but the mode is unchnaged and the machine is running with screen.
> 

Is this one machine with 2 radeons?  If it is, can you try doing an 'fbset -fb 
/dev/fbX' (where X = 0 or 1) and see which one works?  Also, can you try 
booting with this option in your bootloader:

fbcon=map:1

Just to see if the secondary card works okay

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
