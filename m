From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 28 Jun 2013 09:59:58 +0000
Subject: Re: [RFC 3/6] drm: add SimpleDRM driver
Message-Id: <CANq1E4SA4vW3fNRt2c6BV31w0MK8RV7F0CTCuq03y-ko_s2kSg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372112849-670-1-git-send-email-dh.herrmann@gmail.com>
	<1372112849-670-4-git-send-email-dh.herrmann@gmail.com>
	<51C8ECC7.4030404@mit.edu>
In-Reply-To: <51C8ECC7.4030404@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@amacapital.net>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@gmail.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Olof Johansson <olof@lixom.net>

Hi

On Tue, Jun 25, 2013 at 3:05 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On 06/24/2013 03:27 PM, David Herrmann wrote:
>> +     sdrm->fb_map = ioremap(sdrm->fb_base, sdrm->fb_size);
>
> This should probably be ioremap_wc.  Otherwise it will be *really* slow
> if used in legacy mode and it may cause conflicts with the
> pgprot_writecombine mode for mmap.

Whoops, yepp, I fixed that.

Thanks
David
