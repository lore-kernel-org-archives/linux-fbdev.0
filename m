From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] fb: add support for handoff from
	firmware to hw framebuffers
Date: Fri, 5 Jun 2009 16:09:47 +1000
Message-ID: <21d7e9970906042309p3eebe2ewfcc5377803c998bd@mail.gmail.com>
References: <1244090788-31645-1-git-send-email-airlied@gmail.com>
	<4A27DD82.3010305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <airlied@gmail.com>) id 1MCScf-0001B6-O8
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Jun 2009 06:09:49 +0000
Received: from yw-out-2324.google.com ([74.125.46.29])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MCSce-0003yw-9U for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Jun 2009 06:09:49 +0000
In-Reply-To: <4A27DD82.3010305@redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Peter Jones <pjones@redhat.com>
Cc: linux-fbdev-devel@lists.sf.net

On Fri, Jun 5, 2009 at 12:43 AM, Peter Jones<pjones@redhat.com> wrote:
> On 06/04/2009 12:46 AM, Dave Airlie wrote:
>> From: Dave Airlie <airlied@redhat.com>
>>
>> With KMS we have ran into an issue where we really want the KMS fb driver
>> to be the one running the console, so panics etc can be shown by switchi=
ng
>> out of X etc.
>>
>> However with vesafb/efifb built-in, we end up with those on fb0 and the
>> KMS fb driver on fb1, driving the same piece of hw, so this adds an fb i=
nfo
>> flag to denote a firmware fbdev, and adds a new aperture base/size range
>> which can be compared when the hw drivers are installed to see if there
>> is a conflict with a firmware driver, and if there is the firmware drive=
r is
>> unregistered and the hw driver takes over.
>>
>> It uses new aperture_base/size members instead of comparing on the fix
>> smem_start/length, as smem_start/length might for example only cover the
>> first 1MB of the PCI aperture, and we could allocate the kms fb from 8MB
>> into the aperture, thus they would never overlap.
>>
>> Signed-off-by: Dave Airlie <airlied@redhat.com>
>> ---
>> =A0drivers/gpu/drm/i915/intel_fb.c | =A0 =A08 ++++++++
>> =A0drivers/video/efifb.c =A0 =A0 =A0 =A0 =A0 | =A0 =A05 ++++-
>> =A0drivers/video/fbmem.c =A0 =A0 =A0 =A0 =A0 | =A0 24 ++++++++++++++++++=
++++++
>> =A0drivers/video/vesafb.c =A0 =A0 =A0 =A0 =A0| =A0 =A06 +++++-
>> =A0include/linux/fb.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A09 ++++++++-
>> =A05 files changed, 49 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/intel_fb.c b/drivers/gpu/drm/i915/inte=
l_fb.c
>> index e4652dc..f1849d3 100644
>> --- a/drivers/gpu/drm/i915/intel_fb.c
>> +++ b/drivers/gpu/drm/i915/intel_fb.c
>> @@ -504,6 +504,14 @@ static int intelfb_create(struct drm_device *dev, u=
int32_t fb_width,
>> =A0 =A0 =A0 info->fbops =3D &intelfb_ops;
>>
>> =A0 =A0 =A0 info->fix.line_length =3D fb->pitch;
>> +
>> + =A0 =A0 /* setup aperture base/size for vesafb takeover */
>> + =A0 =A0 info->aperture_base =3D dev->mode_config.fb_base;
>> + =A0 =A0 if (IS_I9XX(dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->aperture_size =3D pci_resource_len(dev->=
pdev, 2);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 info->aperture_size =3D pci_resource_len(dev->=
pdev, 0);
>> +
>> =A0 =A0 =A0 info->fix.smem_start =3D dev->mode_config.fb_base + obj_priv=
->gtt_offset;
>> =A0 =A0 =A0 info->fix.smem_len =3D size;
>>
>> diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
>> index 8dea2bc..eb12182 100644
>> --- a/drivers/video/efifb.c
>> +++ b/drivers/video/efifb.c
>> @@ -280,6 +280,9 @@ static int __init efifb_probe(struct platform_device=
 *dev)
>> =A0 =A0 =A0 info->pseudo_palette =3D info->par;
>> =A0 =A0 =A0 info->par =3D NULL;
>>
>> + =A0 =A0 info->aperture_base =3D efifb_fix.smem_start;
>> + =A0 =A0 info->aperture_size =3D size_total;
>> +
>
> It seems like we aught to be looking up the PCI BAR here, reserving it, a=
nd
> using that as aperture_{base,size} -- though that's not strictly required=
 by
> fb_compare_aperture_sizes() .

Probably no need, they'll overlap at some point, and we can't always assume
you'll have a PCI device behind it (well you probably can for efifb.)

>
>>
>> +static bool fb_compare_aperture_sizes(struct fb_info *gen, struct fb_in=
fo *hw)
>
> The name here seems weird -- something like fb_do_apertures_overlap() or =
even just fb_compare_apertures() would be more clear to me.

Changed in v2.

>> + =A0 =A0 =A0 =A0 =A0 =A0 if (registered_fb[i]->flags & FBINFO_MISC_FIRM=
WARE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fb_compare_aperture_sizes(=
registered_fb[i], fb_info)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("fb: co=
nflicting fb hw usage - removing generic driver\n", registered_fb[i]->apert=
ure_base, fb_info->aperture_base);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unregister_fra=
mebuffer(registered_fb[i]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>
> Seems like we should we also have a "nomodeset" check in this codepath.

Shouldn't matter, the kms drivers won't create an fbdev if nomodeset
is specified so we never get to this point

I've sent v2 which is probably ready for inclusion, not sure what the
path upstream is,

After its merged you can add an efifb fb_destroy function, and the
powerpc people can add offb support.

Dave.

---------------------------------------------------------------------------=
---
OpenSolaris 2009.06 is a cutting edge operating system for enterprises =

looking to deploy the next generation of Solaris that includes the latest =

innovations from Sun and the OpenSource community. Download a copy and =

enjoy capabilities such as Networking, Storage and Virtualization. =

Go to: http://p.sf.net/sfu/opensolaris-get
