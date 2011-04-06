From: Dave Airlie <airlied@gmail.com>
Date: Wed, 06 Apr 2011 00:50:04 +0000
Subject: Re: [PATCH] fb: Reduce priority of resource conflict message
Message-Id: <BANLkTimU9yxA21eK7+Y67R9qxgGA57ojMg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301953194-6706-1-git-send-email-mjg@redhat.com>
In-Reply-To: <1301953194-6706-1-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Tue, Apr 5, 2011 at 7:39 AM, Matthew Garrett <mjg@redhat.com> wrote:
> It's expected that efifb will conflict with a native driver, so the
> handover message should be informational rather than an error.
>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>

Acked-by: Dave Airlie <airlied@redhat.com>

Dave.

> ---
> =A0drivers/video/fbmem.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index e2bf953..e0c2284 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -1507,7 +1507,7 @@ void remove_conflicting_framebuffers(struct apertur=
es_struct *a,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(primary && gen_aper && ge=
n_aper->count &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gen_aper->ranges[0].base =
=3D VGA_FB_PHYS)) {
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "fb: confli=
cting fb hw usage "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "fb: confl=
icting fb hw usage "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s vs %s - r=
emoving generic driver\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name, registe=
red_fb[i]->fix.id);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unregister_framebuffer(reg=
istered_fb[i]);
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
