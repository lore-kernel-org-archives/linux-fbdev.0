From: Rob Herring <robh@kernel.org>
Date: Tue, 22 May 2018 17:31:55 +0000
Subject: Re: [PATCH v2 11/11] docs: fix broken references with multiple hints
Message-Id: <20180522173155.GA11767@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
 <63a4f8a93f9115475bc184d0f37d076c9b9c75ff.1525870886.git.mchehab+samsung@kernel.org>
In-Reply-To: <63a4f8a93f9115475bc184d0f37d076c9b9c75ff.1525870886.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, devel@driverdev.osuosl.org, Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>, linux-input@vger.kernel.org, Roy Pledge <Roy.Pledge@nxp.com>, "Serge E. Hallyn" <serge@hallyn.com>, devicetree@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jiri Kosina <jikos@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-gpio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.orgHa

On Wed, May 09, 2018 at 10:18:54AM -0300, Mauro Carvalho Chehab wrote:
> The script:
> 	./scripts/documentation-file-ref-check --fix-rst
> 
> Gives multiple hints for broken references on some files.
> Manually use the one that applies for some files.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/ABI/obsolete/sysfs-gpio                     | 2 +-
>  .../devicetree/bindings/display/bridge/tda998x.txt        | 2 +-

Acked-by: Rob Herring <robh@kernel.org>

>  Documentation/trace/events.rst                            | 2 +-
>  Documentation/trace/tracepoint-analysis.rst               | 2 +-
>  Documentation/translations/zh_CN/SubmittingDrivers        | 2 +-
>  Documentation/translations/zh_CN/gpio.txt                 | 4 ++--
>  MAINTAINERS                                               | 2 +-
>  drivers/hid/usbhid/Kconfig                                | 2 +-
>  drivers/input/Kconfig                                     | 4 ++--
>  drivers/input/joystick/Kconfig                            | 4 ++--
>  drivers/input/joystick/iforce/Kconfig                     | 2 +-
>  drivers/input/serio/Kconfig                               | 4 ++--
>  drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt           | 2 +-
>  drivers/video/fbdev/skeletonfb.c                          | 8 ++++----
>  include/linux/tracepoint.h                                | 2 +-
>  security/device_cgroup.c                                  | 2 +-
>  16 files changed, 23 insertions(+), 23 deletions(-)
