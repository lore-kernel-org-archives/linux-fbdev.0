From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Thu, 21 Mar 2013 10:15:26 +0000
Subject: Re: [PATCH v2 3/8] drivers: char: use module_platform_driver_probe()
Message-Id: <CAHkwnC_AJpeVw2o8oJn+zMvSg1Lbmm1aXRYxCmtDYhkJG9nvig@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363280978-24051-1-git-send-email-fabio.porcedda@gmail.com>
 <1363280978-24051-4-git-send-email-fabio.porcedda@gmail.com>
 <20130321095542.GH26931@gondor.apana.org.au>
In-Reply-To: <20130321095542.GH26931@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Mar 21, 2013 at 10:55 AM, Herbert Xu
<herbert@gondor.apana.org.au> wrote:
> On Thu, Mar 14, 2013 at 06:09:33PM +0100, Fabio Porcedda wrote:
>> This patch converts the drivers to use the
>> module_platform_driver_probe() macro which makes the code smaller and
>> a bit simpler.
>>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Matt Mackall <mpm@selenic.com>
>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>> Cc: Fabio Estevam <fabio.estevam@freescale.com>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>
> Patch applied.

The patch is already in
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git.
Are you speaking about that?

Best regards
--
Fabio Porcedda
