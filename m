From: Denis Oliver Kropp <dok@directfb.org>
Subject: Re: DirectFB without FBDev
Date: Wed, 28 May 2008 19:20:19 +0200
Message-ID: <483D9453.1080700@directfb.org>
References: <483D7344.6030503@directfb.org>
	<Pine.LNX.4.64.0805281901300.15083@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1PKJ-0007WX-4C for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 10:20:39 -0700
Received: from directfb.org ([212.227.87.76] helo=www.directfb.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K1PKH-00087r-JF
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 May 2008 10:20:38 -0700
In-Reply-To: <Pine.LNX.4.64.0805281901300.15083@anakin>
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
> 	Hi Denis,
> 
> On Wed, 28 May 2008, Denis Oliver Kropp wrote:
>> One major bug at the moment is mode switching and pitch values being wrong. It's dumb to
>> return the pitch of the variable mode settings in the fixed settings structure anyhow, but
>> if you like to start with the above mentioned mission, that's where it could begin.
> 
> Do you care to tell us why this is dumb?

Ok, the fixed information should not contain information that changes over time,
otherwise it is not fixed, at least that's my understanding of "fixed".

> The pitch depends on the video mode and the hardware requirements,
> that's why it's in struct fb_fix_screeninfo.

It would suffice to encode the pitch requirements independent from the video mode,
i.e. just put the pixel or byte alignment into the fixed structure.

>> And while you're at it, please also add an ioctl to just simply set the display offset without
>> a virtual resolution and x/y offset values within the whole frame buffer...
> 
> Why do you need this? What's different compared to setting a virtual
> resolution and a y offset (I assume you're talking about y only, as an x
> offset without a virtual resolution doesn't make much sense).

If you see the frame buffer as a big pool of memory in which you can allocate chunks
for being displayed or otherwise used by the hardware, it is a handicap if you need to
specify the offset of these buffers in non-linear mode after putting some 2D coordinate
system onto the 1D memory area.

I'd propose to allow user space to choose any byte offset and pitch as part of the variable
information that is compatible with the hardware. To achieve this the constrains should be
put into the fixed information.

fb_var_screeninfo
- remove/disable x_offset/y_offset
+ add byte_offset/byte_pitch

fb_fix_screeninfo
- remove variable pitch info
+ add byte/pixel alignment constrains for offset and pitch

Furthermore, the pan_display functionality could be enhanced to allow a kernel side queue
for frame accurate display of several buffers, e.g. video playback with five or more buffers
pre-rendered. A frame/sync counter and some new flags would be enough to be added for this.

Ville Syrjala once did an extension like FBIO_FLIP or similar, maybe he can elaborate.

I'm also seeing the need to have one pool of memory used by different frame buffer devices
or some other way to support multiple layers without statically partitioning memory that could
be managed more intelligently.

And how about such capabilities like layer opacity, alpha ramps...?

I know all this was not required to run the kernel based terminal emulation that the frame
buffer device has been invented for :)

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
