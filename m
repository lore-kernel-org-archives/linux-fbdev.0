From: Dave Airlie <airlied@gmail.com>
Date: Sun, 03 Apr 2011 21:29:57 +0000
Subject: Re: PATCH: New Matrox PCI ID
Message-Id: <BANLkTin4225md0VGbfmSzSfJ0FHjq9ST9A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4D98DD1C.4080300@digadd.de>
In-Reply-To: <4D98DD1C.4080300@digadd.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Apr 4, 2011 at 6:48 AM, Christian Schmidt <charlie@digadd.de> wrote:
> Hi,
>
> The attached patch adds the PCI ID for the Matrox G200eW. Console
> Framebuffer selection via video= parameter works.
>
> Regards,
> Christian
>

NAK.

There is a patch to rip out matrox g200ev support since it never worked.

so I'm not sure why adding 200eW would be a plan.

Dave.
