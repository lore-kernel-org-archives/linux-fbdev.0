From: Denis Oliver Kropp <dok@directfb.org>
Subject: Re: DirectFB without FBDev
Date: Wed, 28 May 2008 20:33:35 +0200
Message-ID: <483DA57F.6070602@directfb.org>
References: <483D7344.6030503@directfb.org>
	<Pine.LNX.4.64.0805281901300.15083@anakin>
	<483D9453.1080700@directfb.org>
	<Pine.LNX.4.64.0805281948080.15083@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1QUH-0006y9-Cl for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 11:35:01 -0700
Received: from directfb.org ([212.227.87.76] helo=www.directfb.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K1QUC-0002hz-Qa
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 11:35:01 -0700
In-Reply-To: <Pine.LNX.4.64.0805281948080.15083@anakin>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, directfb-users@directfb.org, directfb-dev@directfb.org

Geert Uytterhoeven wrote:
> On Wed, 28 May 2008, Denis Oliver Kropp wrote:
>> Geert Uytterhoeven wrote:
>>> On Wed, 28 May 2008, Denis Oliver Kropp wrote:
>>>> One major bug at the moment is mode switching and pitch values being
>>>> wrong. It's dumb to
>>>> return the pitch of the variable mode settings in the fixed settings
>>>> structure anyhow, but
>>>> if you like to start with the above mentioned mission, that's where it
>>>> could begin.
>>> Do you care to tell us why this is dumb?
>> Ok, the fixed information should not contain information that changes over
>> time,
>> otherwise it is not fixed, at least that's my understanding of "fixed".
> 
> It's `fixed' not in the sense that it can never change, but that it
> purely depends on the info in struct fb_var_screeninfo.

I'd prefer an ioctl which has input and output fields in the accompanied struct,
so that the resulting pitch is returned to the user space with the same system call.

>>> The pitch depends on the video mode and the hardware requirements,
>>> that's why it's in struct fb_fix_screeninfo.
>> It would suffice to encode the pitch requirements independent from the video
>> mode,
>> i.e. just put the pixel or byte alignment into the fixed structure.
> 
> What if the pitch requirements depend on the video mode?

Haven't seen that, usually either pixels or bytes just needs to be a multiple
of something. In these cases you could simply forbid/fail to choose the pitch and
just return it in the variable structure.

> There exists graphics hardware where fb_fix_screeninfo.type depends on
> the video mode.

Sure, type depends on the pixelformat :)

-- 
Best regards,
   Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
