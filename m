From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Finally found why 2.6.x has troubles with taking over vgacon
Date: Sun, 4 Jul 2004 08:58:22 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407040858.22088.adaplas@hotpop.com>
References: <20040703195613.GA30739@vana.vc.cvut.cz>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgvJr-0006m1-OU
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Jul 2004 17:57:23 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BgvJr-0001C1-Ct
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Jul 2004 17:57:23 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id 3D1DC747BB
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat,  3 Jul 2004 23:52:02 +0000 (UTC)
In-Reply-To: <20040703195613.GA30739@vana.vc.cvut.cz>
Content-Disposition: inline
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sunday 04 July 2004 03:56, Petr Vandrovec wrote:
> Hi Antonio,
>   yesterday I finally found why 2.6.x has problems with taking over vgacon.
> Problem is that take_over_console does:
>
>
>   if (IS_VISIBLE)
>     save_screen(i);
>   ...
>   visual_init(i, 0);
>   ...
>
> so code nicely saves screen contents, and calls visual_init, which calls
> fbcon's init, which in turn can issue vc_resize. And this vc_resize will
> trigger read from vc->vc_origin. But vc_origin still points to videomemory,
> not to the buffer where save_screen() copied its data.
>
>   In my fbcon
> (http://platan.vc.cvut.cz/ftp/pub/linux/matrox-latest/matroxfb-2.6.7-c1784.
>tar.gz) after I put
>
>   origin = visual_origin = screenbuf;
>
> below save_screen call, and removed clearing screen from radeon sources
> both radeonfb and matroxfb were able to take over vgacon, without any
> randomly colored characters on screen.

Petr, excellent detective work :-) .  I was suspecting vc_resize() was partly
causing the corruption, but never knew the reason until you pointed this

>
>   It also allows for removing special fillrect clear, as now code
> which clears upper few lines of logo area actually works...

Yes, I can now finally remove that ugly fillrect code.  I'll submit a patch on the
next batch of mm or BK release. 

Thanks.

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
