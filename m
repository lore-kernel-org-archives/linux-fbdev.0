From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 28 Jun 2013 17:41:25 +0000
Subject: Re: imx-drm does not report correct info in fbset
Message-Id: <CAOMZO5ArQdCmQGoEW=57sr4pJhssKXKQhTmDxHo7cVfA1q82Cw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOMZO5A=JSHJrkXwXkYYxbkjtcFv3NU5W6F4hSb5Y7ZrpKij=A@mail.gmail.com>
In-Reply-To: <CAOMZO5A=JSHJrkXwXkYYxbkjtcFv3NU5W6F4hSb5Y7ZrpKij=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jun 28, 2013 at 2:28 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Philipp/Sascha,
>
> When I enable the parallel display on a mx53qsb, I noticed that fbset
> does not report the correct information:
>
> mode "800x480-0"
>         # D: 0.000 MHz, H: 0.000 kHz, V: 0.000 Hz
>         geometry 800 480 800 480 16
>         timings 0 0 0 0 0 0 0

Ok, just realized that my host PC reports the same in the 'timings' line.

So not an issue with the imx-drm driver then.

Regards,

Fabio Estevam
