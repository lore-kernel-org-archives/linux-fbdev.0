From: "Michal Suchanek" <hramrach@centrum.cz>
Subject: Re: reguest for comments regarding an imac_fb
	and efifb unification
Date: Fri, 7 Mar 2008 08:49:35 +0100
Message-ID: <a5d587fb0803062349q61981b2dj1656e535ff5e5659@mail.gmail.com>
References: <p0623091ac3f5e718e844@192.168.9.5>
	<Pine.LNX.4.64.0803062038100.26657@anakin>
	<p0623091cc3f5f9111ec0@192.168.9.5>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JXXKm-00082L-Cz for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Mar 2008 23:49:50 -0800
Received: from ug-out-1314.google.com ([66.249.92.168])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JXXKj-0003ag-Gx
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Mar 2008 23:49:38 -0800
Received: by ug-out-1314.google.com with SMTP id m2so3850494uge.28
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 06 Mar 2008 23:49:36 -0800 (PST)
In-Reply-To: <p0623091cc3f5f9111ec0@192.168.9.5>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

On 06/03/2008, Scott D. Davilla <davilla@4pi.com> wrote:
> >  > Which brings up the point, is there another more general console
>  >>  frame buffer that could replace both imac_fb and efifb? It seems that
>  >>  a generic console framebuffer that assumes a linear video framebuffer
>  >>  that does not make video bios calls (nor PC bios) and can be
>  >>  configured by screen_info params or command-line params would be
>  >>  something that already exists? Is there such a console frame buffer?
>  >>
>  >>  I'm willing to pursue this but I want to check the general consensus
>  >>  about such a venture and possible ramifications that I might not have
>  >>  considered.
>  >
>  >There exist a few more drivers for simple linear video frame buffer
>  >devices with fixed x,y dimensions:
>  >   - offb, for Open Firmware based machines,
>  >   - vesafb, for VBE 2.0 compliant graphic boards.
>
>
> vesafb would be nice but there is an implied VBE 2.0 compliance which
>  includes video bios. I'll force my bootloader to vesafb and see how
>  far it gets.
>

Perhaps you want something like linfb which would act as backend for
various fb (auto)configuration methods. efifb through parameters
passed by efi bootloader on the commandline, imacfb by reading the mac
bios, offb by reading the ofw, vesafb by reading the vesa bios, etc.

However, I am not familiar with the kernel fb, all I can say is I
could probably test offb and imacfb if you did the merge.

iirc the offb was special in that one could load another fb over it
even before fb switching was possible (or was it ofconsole?)

Another speciality is vesafb_tng or whatever it's called which is
supposed to be able to change the resolution even after boot.

Thanks

Michal

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
