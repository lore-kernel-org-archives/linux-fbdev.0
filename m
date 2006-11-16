From: "=?UTF-8?Q?Jaya_Kumar_?=  =?UTF-8?Q?(=E0=AE=9C=E0=AF=86=E0=AE=AF=E0=AE=BE=E0=AE=95?=  =?UTF-8?Q?=E0=AF=81=E0=AE=AE=E0=AE=BE=E0=AE=B0=E0=AF=8D)?=" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.18.1 1/1] Framebuffer driver for
	Hecuba/E-Ink display
Date: Thu, 16 Nov 2006 04:49:10 +0100
Message-ID: <45a44e480611151949n1afe3252n1864ced2a430d3a6@mail.gmail.com>
References: <45a44e480611142315k33d8df02y73f73ce9b3a3b111@mail.gmail.com>
	<Pine.LNX.4.62.0611160239180.16998@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GkYFU-0006HK-Vy for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Nov 2006 19:49:13 -0800
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GkYFT-0007cV-Oj
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Nov 2006 19:49:13 -0800
Received: by py-out-1112.google.com with SMTP id a29so242521pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 15 Nov 2006 19:49:11 -0800 (PST)
In-Reply-To: <Pine.LNX.4.62.0611160239180.16998@pademelon.sonytel.be>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On 11/16/06, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Yep, sounds like a nice idea to try, and compare with other methods, like e.g.
> copying the frame buffer to the external device every vsync.
>
> But I guess the `every vsync' is not a good idea for e-ink, as it's very slow
> to update?
>

Yes, you are right. The typical display update for this particular
display is about 500ms to 800 ms. To clarify, the display is static
(non-volatile pixels basically) and thereby is not refresh associated.

One of the common concerns when using this display is power. This is
where I think the method of only updating the display (and waking up
the controller) when triggered by the page fault may help. Also
differencing is made easier because we would know which pages have
been touched.

Thanks,
jaya

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
