From: Alexandre Courbot <gnurou@gmail.com>
Date: Tue, 28 May 2013 02:31:22 +0000
Subject: Re: [PATCH v2] video: simplefb: add mode parsing function
Message-Id: <CAAVeFuJssMGNi=7gtxHjgaS9s+VTkfBme+T68=Zf7Ech2+hMQw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369626821-28494-1-git-send-email-acourbot@nvidia.com>
 <CANq1E4Qa6g-zrA6o_u3w6mpVcUk8-ZPPR+edu6EXgpk-kGQULQ@mail.gmail.com>
In-Reply-To: <CANq1E4Qa6g-zrA6o_u3w6mpVcUk8-ZPPR+edu6EXgpk-kGQULQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi David,

On Tue, May 28, 2013 at 3:22 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> If we apply this patch it will get very hard to support this with a
> KMS driver. So any reason why we cannot use the DRM FOURCC constants
> instead?

I don't see any. Maybe Stephen can confirm.

> The dvbe proposal is available here: (also see the two following patches)
>   http://lkml.indiana.edu/hypermail/linux/kernel/1302.2/00274.html
>
> it provides a simple DRM driver that uses VESA / VBE. I am currently
> trying to rework it to "SimpleDRM" which can support arbitrary
> firmware framebuffers.

Ok. I am personally fine with using FOURCC codes for describing video
modes. Maybe we can just drop this patch if it gets in your way.

Alex.
