From: "Brian G. Rhodes" <bgr-3mWahjwryh5BDgjK7y7TUQ@public.gmane.org>
Subject: Re: [Linux-fbdev-devel] DirectFB without FBDev
Date: Wed, 28 May 2008 12:53:52 -0500
Message-ID: <483D9C30.8010301@acdstar.com>
References: <483D7344.6030503@directfb.org>	<Pine.LNX.4.64.0805281901300.15083@anakin>
	<483D9453.1080700@directfb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <483D9453.1080700-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://mail.directfb.org/cgi-bin/mailman/listinfo/directfb-users>,
	<mailto:directfb-users-request-iGvX3keArt1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://mail.directfb.org/pipermail/directfb-users>
List-Post: <mailto:directfb-users-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:directfb-users-request-iGvX3keArt1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <http://mail.directfb.org/cgi-bin/mailman/listinfo/directfb-users>,
	<mailto:directfb-users-request-iGvX3keArt1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Sender: directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org
Errors-To: directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org
To: Denis Oliver Kropp <dok-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
Cc: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, directfb-users-iGvX3keArt1g9hUCZPvPmw@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, directfb-dev-iGvX3keArt1g9hUCZPvPmw@public.gmane.org



Denis Oliver Kropp wrote:
> Geert Uytterhoeven wrote:
>   
>> 	Hi Denis,
>>
>> On Wed, 28 May 2008, Denis Oliver Kropp wrote:
>>     
>>> One major bug at the moment is mode switching and pitch values being wrong. It's dumb to
>>> return the pitch of the variable mode settings in the fixed settings structure anyhow, but
>>> if you like to start with the above mentioned mission, that's where it could begin.
>>>       
>> Do you care to tell us why this is dumb?
>>     
>
> Ok, the fixed information should not contain information that changes over time,
> otherwise it is not fixed, at least that's my understanding of "fixed".
>
>   
>> The pitch depends on the video mode and the hardware requirements,
>> that's why it's in struct fb_fix_screeninfo.
>>     
>
> It would suffice to encode the pitch requirements independent from the video mode,
> i.e. just put the pixel or byte alignment into the fixed structure.
>
>   
>>> And while you're at it, please also add an ioctl to just simply set the display offset without
>>> a virtual resolution and x/y offset values within the whole frame buffer...
>>>       
>> Why do you need this? What's different compared to setting a virtual
>> resolution and a y offset (I assume you're talking about y only, as an x
>> offset without a virtual resolution doesn't make much sense).
>>     
>
> If you see the frame buffer as a big pool of memory in which you can allocate chunks
> for being displayed or otherwise used by the hardware, it is a handicap if you need to
> specify the offset of these buffers in non-linear mode after putting some 2D coordinate
> system onto the 1D memory area.
>
> I'd propose to allow user space to choose any byte offset and pitch as part of the variable
> information that is compatible with the hardware. To achieve this the constrains should be
> put into the fixed information.
>
> fb_var_screeninfo
> - remove/disable x_offset/y_offset
> + add byte_offset/byte_pitch
>
> fb_fix_screeninfo
> - remove variable pitch info
> + add byte/pixel alignment constrains for offset and pitch
>
> Furthermore, the pan_display functionality could be enhanced to allow a kernel side queue
> for frame accurate display of several buffers, e.g. video playback with five or more buffers
> pre-rendered. A frame/sync counter and some new flags would be enough to be added for this.
>   
> Ville Syrjala once did an extension like FBIO_FLIP or similar, maybe he can elaborate.
>
> I'm also seeing the need to have one pool of memory used by different frame buffer devices
> or some other way to support multiple layers without statically partitioning memory that could
> be managed more intelligently.
>
> And how about such capabilities like layer opacity, alpha ramps...?
>
> I know all this was not required to run the kernel based terminal emulation that the frame
> buffer device has been invented for :)
>
>   

I don't think the solution to abstracting access to multiple hardware 
planes which can be located in at dynamic memory addresses to be 
implemented by adding complexity to the framebuffer driver.  It is 
supposed to be just a dumb chunk of memory and storage for hardware timings.

Considering video, and the amount of data which has to be shuffled 
around for higher resolution/bitrate files it does not make sense to 
require sending rendered frames off directly to a framebuffer device.  
It is too inefficient and in cases with hardware-assist (other than 
coprocessors), likely unnecessary.  The answer probably isn't using 
Video4Linux directly either.  Perhaps a DirectFB kernel component which 
can standardize an interface and provide a better architecture than v4l2 
does.  An application where, as mentioned above, you are using video 
memory for multiple buffers as a implementation for queuing seems too 
specialized to me to ever be done in a linuxfb driver.

Has any thought been given to designing a DirectFB kernel-space 
component which abstracts that access at the kernel level?  Seems to me 
that it would make direct interaction from directfb with specialized 
hardware much easier.
