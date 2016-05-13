From: "Yang, Eric" <Eric.Yang2@amd.com>
Date: Fri, 13 May 2016 20:02:29 +0000
Subject: Re: [PATCH] drm: expand cea861 mode timing table
Message-Id: <BY2PR1201MB092002212FD673E35A6789E8CD740@BY2PR1201MB0920.namprd12.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1463081853-14942-1-git-send-email-eric.yang2@amd.com>,
 <20160513152839.GA24232@ulmo.ba.sec>
In-Reply-To: <20160513152839.GA24232@ulmo.ba.sec>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

Hi Thierry Reding,

I will have to answer this question next week, the member of my team with a HDMI spec is not here today.

Hi Jani Nikula,
Thank you for noticing the formatting mistake, the checkpatch script did not catch this, I will prepare a new patch with the formatting fixed.
________________________________________
From: Thierry Reding <thierry.reding@gmail.com>
Sent: Friday, May 13, 2016 11:28:39 AM
To: Yang, Eric
Cc: dri-devel@lists.freedesktop.org; linux-fbdev@vger.kernel.org; tomi.valkeinen@ti.com; plagnioj@jcrosoft.com
Subject: Re: [PATCH] drm: expand cea861 mode timing table

On Thu, May 12, 2016 at 03:37:33PM -0400, Eric Yang wrote:
[...]
> diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
> index e974420..edbb4fc 100644
> --- a/include/linux/hdmi.h
> +++ b/include/linux/hdmi.h
> @@ -78,6 +78,8 @@ enum hdmi_picture_aspect {
>       HDMI_PICTURE_ASPECT_NONE,
>       HDMI_PICTURE_ASPECT_4_3,
>       HDMI_PICTURE_ASPECT_16_9,
> +     HDMI_PICTURE_ASPECT_64_27,
> +     HDMI_PICTURE_ASPECT_256_135,
>       HDMI_PICTURE_ASPECT_RESERVED,
>  };

Where did you get these from? I'm asking because I sent this patch last
year (or at least I wrote it and we discussed it on IRC, since I can't
find an email archive link to it), and back at the time the picture
aspect ratio was the big question mark. My recollection is that
CEA-861-F introduces these new picture aspect ratios in the mode tables
but never specifies their values. As a matter of fact, the AVI infoframe
where these values are used only has space for 4 values (none, 4:3, 16:9
and reserved).

Would you mind pointing me at the specification for these values?

Thanks,
Thierry
