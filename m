From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Thu, 14 Mar 2013 17:51:58 +0000
Subject: Re: [PATCH v2 4/8] drivers: input: use module_platform_driver_probe()
Message-Id: <CAHkwnC-vOPxqWq3jF=sbDrhvyWhNYvV5rAd69K8b5iH3KyqyPQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363280978-24051-1-git-send-email-fabio.porcedda@gmail.com>
 <1363280978-24051-5-git-send-email-fabio.porcedda@gmail.com>
 <3681471.ufqahH3gTF@dtor-d630.eng.vmware.com>
In-Reply-To: <3681471.ufqahH3gTF@dtor-d630.eng.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Mar 14, 2013 at 6:30 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Fabio,
>
> On Thursday, March 14, 2013 06:09:34 PM Fabio Porcedda wrote:
>> This patch converts the drivers to use the
>> module_platform_driver_probe() macro which makes the code smaller and
>> a bit simpler.
>
> I already have patches from Sachin Kamat for this, I am waiting for -rc3
> to sync up with mainline and pick up the macro before applying them.

Thank for reviewing.

I've sent a updated patch without the patch already sent by Sachin Kamat.

Best regards
Fabio Porcedda

> Thanks.
>
> --
> Dmitry
