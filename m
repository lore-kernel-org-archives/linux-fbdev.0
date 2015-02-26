From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 26 Feb 2015 11:06:59 +0000
Subject: Re: [RFC] pwm-backlight: Allow backlight to remain disabled on boot
Message-Id: <20150226110659.GO6688@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1406806970-12561-1-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1406806970-12561-1-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, 31 Jul 2014, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> The default for backlight devices is to be enabled immediately when
> registering with the backlight core. This can be useful for setups that
> use a simple framebuffer device and where the backlight cannot otherwise
> be hooked up to the panel.
>=20
> However, when dealing with more complex setups, such as those of recent
> ARM SoCs, this can be problematic. Since the backlight is usually setup
> separately from the display controller, the probe order is not usually
> deterministic. That can lead to situations where the backlight will be
> powered up and the panel will show an uninitialized framebuffer.
>=20
> Furthermore, subsystems such as DRM have advanced functionality to set
> the power mode of a panel. In order to allow such setups to power up the
> panel at exactly the right moment, a way is needed to prevent the
> backlight core from powering the backlight up automatically when it is
> registered.
>=20
> This commit introduces a new boot_off field in the platform data (and
> also implements getting the same information from device tree). When set
> the initial backlight power mode will be set to "off".
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> I've been meaning to send this for a while but was always holding back
> because of the indoctrination that this type of configuration shouldn't
> be part of device tree. However this issue was recently raised again in
> the context of power up sequences for display panels. As described above
> the issue is that panel datasheets recommend that the backlight attached
> to a panel be turned on at the very last step to avoid visual glitches
> during the panel's power up sequence. With the current implementation it
> is typical for the backlight to be probed before the display panel. That
> has, in many cases, the side-effect of enabling the backlight, therefore
> making the screen content visible before it's actually initialized.
>=20
> Some panels come up with random garbage when uninitialized, others show
> all white. With some luck the panel will be all black and users won't
> really notice.
>=20
> This patch is an attempt to enable boards to override the default of
> turning on the backlight for the pwm-backlight driver. I'm not sure if
> there was a specific reason to turn on the backlight by default when
> this driver was initially written, but the fact is that since it has
> pretty much always been like this we can't really go and change the
> default, otherwise a lot of people may end up with no backlight and no
> clue as to how to enable it. So the only reasonable thing we can do is
> to keep the old behaviour and give new boards a way to override it if
> they know that some other part of the stack will enable it at the right
> moment.
>=20
>  .../devicetree/bindings/video/backlight/pwm-backlight.txt         | 1 +
>  drivers/video/backlight/pwm_bl.c                                  | 8 ++=
++++++
>  include/linux/pwm_backlight.h                                     | 2 ++
>  3 files changed, 11 insertions(+)

Some people on the list are talking about this again.

What was the verdict?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
