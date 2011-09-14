From: Tormod Volden <lists.tormod@gmail.com>
Date: Wed, 14 Sep 2011 06:54:54 +0000
Subject: Re: [REPOST][PATCH 2/2] video: miscellaneous minor changes to the
Message-Id: <CAArsGaY9wR-CU1-6Q_eJ_V1dzSP3o5z=nML=YGQ-S_j=wicqyg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1315929909-26311-2-git-send-email-timur@freescale.com>
In-Reply-To: <1315929909-26311-2-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Tue, Sep 13, 2011 at 6:05 PM, Timur Tabi <timur@freescale.com> wrote:
> Make several minor, miscellaneous changes to the Freescale DIU framebuffer
> driver. =A0These changes "lighten" the code by removing crud, fixing small
> bugs, and fixing some coding style problems. =A0These changes will make it
> easier to make more substantial fixes in the future.

It would be much easier to review this if it is split up into several
commits. At least have the whitespace fixes in a separate commit, and
also the actual bug fixes. "git add -p" is your friend.

> 1. Fix incorrect indentation and spacing with some code.
> 2. Remove debug printks (they don't actually help in debugging the code).
> 3. Clean up some other printks (e.g. use pr_xxx, clean up the text, etc).
> 4. Remove the "default" videomode object since it's just a dupe of the
> =A0 first element in the videomode array.
> 5. Remove some superfluous local variables.
> 6. Rename ofdev to pdev, since it's a platform device not an OF device.
> 7. Fix some device tree operations.
> 8. Fix some build warnings.
> 9. Removed some unused structures from the header file.
> 10. Other minor bug fixes and changes.

I would have found natural to split it up into commits like for
example: 1, 2+3, 4, 5+8+9, 10.

> @@ -217,59 +201,59 @@ struct mfb_info {
> =A0 =A0 =A0 =A0int x_aoi_d; =A0 =A0 =A0 =A0 =A0 =A0/* aoi display x offse=
t to physical screen */
> =A0 =A0 =A0 =A0int y_aoi_d; =A0 =A0 =A0 =A0 =A0 =A0/* aoi display y offse=
t to physical screen */
> =A0 =A0 =A0 =A0struct fsl_diu_data *parent;
> - =A0 =A0 =A0 u8 *edid_data;
> + =A0 =A0 =A0 void *edid_data;
> =A0};

Why do you convert edid_data from pointer to u8 to pointer to void?

Regards,
Tormod
