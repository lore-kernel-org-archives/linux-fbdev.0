From: Zack <plinius@comcast.net>
Subject: Re: framebuffer ioctl
Date: Sun, 05 Sep 2004 10:13:09 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <413B4925.5000706@comcast.net>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be> <413A3735.9E7D2F11@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C40Zn-00069l-5j
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Sep 2004 10:13:15 -0700
Received: from sccrmhc12.comcast.net ([204.127.202.56])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C40Zm-0007Tv-CL
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Sep 2004 10:13:15 -0700
In-Reply-To: <413A3735.9E7D2F11@orpatec.ch>
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

Otto Wyss wrote:

>Geert Uytterhoeven wrote:
>  
>
>>Would there be any major opposition to my adding
>>some additional functions to the framebuffer ioctl
>>interface? I want to add basic drawing functions,
>>nothing too fancy, but enough to do away with things
>>like SVGAlib.
>>Zack
>>    
>>
>IMO it should only be done if all of the graphic libs like SVGAlib, GGI,
>DirectFB can profit from it. IMO it's very important that the future API
>of the framebuffer in kernel 2.7.x is discussed before such changes are
>done. Maybe a wish list should be started.
>
>O. Wyss
>  
>
Some reasons for moving drawing routines into the kernel include
(correct me if I'm wrong)

1. there is some needless duplication of effort between these
various fullscreen-gui projects (svgalib, ggi, etc)
2. there is afaik presently no good facility for adding acceleration
support for things like drawing lines
3. the chance that any fullscreen-gui project will become broken
due to a new kernel is real (SVGAlib is broken with 2.4.26 & 2.6.7)
4. new features would be optional anyway: fullscreen-guis need not
recognize their existence, but would benefit from doing so
since some fb drivers would override the generic routines
to implement accelerated routines.

Zack




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
