From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 07 Mar 2016 20:03:53 +0000
Subject: Re: [PATCH 0/3] video: fbdev: imxfb: make it work again
Message-Id: <CAOMZO5BxrVHNq8BdOqAqkaOqC905+AOSkFtsrWFHbz4cfN=Kaw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Uwe,

On Mon, Mar 7, 2016 at 4:53 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> it seems the imxfb driver stopped working quite some time ago. Here come

Yes, I noticed it has been broken for a long time.

After this fix I managed to get it working again:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/driv=
ers/video/fbdev/imxfb.c?id=B82fe6ddd782f847332aeabf8cab980852f61629
