From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 26 May 2016 07:53:50 +0000
Subject: Re: [PATCH] drm: expand cea861 mode timing table
Message-Id: <20160526075350.GL27098@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1463081853-14942-1-git-send-email-eric.yang2@amd.com>
 <20160513152839.GA24232@ulmo.ba.sec>
 <BY2PR1201MB092002212FD673E35A6789E8CD740@BY2PR1201MB0920.namprd12.prod.outlook.com>
 <BY2PR1201MB092097051B486290A03DDAA2CD400@BY2PR1201MB0920.namprd12.prod.outlook.com>
In-Reply-To: <BY2PR1201MB092097051B486290A03DDAA2CD400@BY2PR1201MB0920.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Yang, Eric" <Eric.Yang2@amd.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>

On Wed, May 25, 2016 at 07:55:23PM +0000, Yang, Eric wrote:
> Hi Thierry Reding,
> 
> enum hdmi_picture_aspect {
> >       HDMI_PICTURE_ASPECT_NONE,
> >       HDMI_PICTURE_ASPECT_4_3,
> >       HDMI_PICTURE_ASPECT_16_9,
> > +     HDMI_PICTURE_ASPECT_64_27,
> > +     HDMI_PICTURE_ASPECT_256_135,
> >       HDMI_PICTURE_ASPECT_RESERVED,
> >  };
> 
> These are defined since CEA861F defines them in section 4.1.  
> However, it is not indicated in AVI InfoFrame definition for picture aspect ratio (M1,M0), and we should indicate (M1,M0) = (0,0) for "No Data" when sending VICs corresponding to these new aspect ratios.
> 
> If (M1,M0) = (0,0) "No Data" is indicated, then If M=0 (M1=0, M0=0) and VIC=0, a Sink shall assume the Picture is formatted according to the Preferred Picture Aspect Ratio.
> 
> The defition:
> 
> Preferred Picture Aspect Ratio-In a Dual-Aspect Ratio DTV, the preferred aspect ratio of a given Video Format Timing (e.g., 720x480p) is the aspect ratio of the first such timing listed in the EDID data structure (see Section 4.1). This would be the Picture Aspect Ratio that would be displayed if a DTV were to receive a Video Format Timing with no accompanying Picture Aspect Ratio information (i.e., no AVI sent from Source).
> 
> Alternatively, since our code does not actively use HDMI_PICTURE_ASPECT_64_27, HDMI_PICTURE_ASPECT_256_135, we can unify them as HDMI_PICTURE_ASPECT_NONE, and send (M1,M0) = (0,0) to avoid confusion.

There's already drm core patches to add all this stuff for the new aspect
ratios:

https://patchwork.freedesktop.org/series/4896/

Would be great if you can review them. Patch 5 of that series (for
i915.ko) needs to be polished a bit, but the other bits all look fine to
me at a quick glance.

Thanks, Daniel

> 
> 
> 
> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Friday, May 13, 2016 11:28:39 AM
> To: Yang, Eric
> Cc: dri-devel@lists.freedesktop.org; linux-fbdev@vger.kernel.org; tomi.valkeinen@ti.com; plagnioj@jcrosoft.com
> Subject: Re: [PATCH] drm: expand cea861 mode timing table
> 
> On Thu, May 12, 2016 at 03:37:33PM -0400, Eric Yang wrote:
> [...]
> > diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h index 
> > e974420..edbb4fc 100644
> > --- a/include/linux/hdmi.h
> > +++ b/include/linux/hdmi.h
> > @@ -78,6 +78,8 @@ enum hdmi_picture_aspect {
> >       HDMI_PICTURE_ASPECT_NONE,
> >       HDMI_PICTURE_ASPECT_4_3,
> >       HDMI_PICTURE_ASPECT_16_9,
> > +     HDMI_PICTURE_ASPECT_64_27,
> > +     HDMI_PICTURE_ASPECT_256_135,
> >       HDMI_PICTURE_ASPECT_RESERVED,
> >  };
> 
> Where did you get these from? I'm asking because I sent this patch last year (or at least I wrote it and we discussed it on IRC, since I can't find an email archive link to it), and back at the time the picture aspect ratio was the big question mark. My recollection is that CEA-861-F introduces these new picture aspect ratios in the mode tables but never specifies their values. As a matter of fact, the AVI infoframe where these values are used only has space for 4 values (none, 4:3, 16:9 and reserved).
> 
> Would you mind pointing me at the specification for these values?
> 
> Thanks,
> Thierry
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
