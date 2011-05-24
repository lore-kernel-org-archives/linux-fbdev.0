From: Anatolij Gustschin <agust@denx.de>
Date: Tue, 24 May 2011 07:45:13 +0000
Subject: Re: [PATCH 4/5] video: mb862xx: add support for controller's I2C
Message-Id: <20110524094513.5de97cb2@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1305302089-7666-5-git-send-email-agust@denx.de>
In-Reply-To: <1305302089-7666-5-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 24 May 2011 16:23:44 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Fri, May 13, 2011 at 05:54:48PM +0200, Anatolij Gustschin wrote:
> > Add adapter driver for I2C adapter in Coral-P(A)/Lime GDCs.
> > So we can easily access devices on controller's I2C bus using
> > i2c-dev interface.
> > 
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> 
> I don't see anything in the Kconfig that prevents this from being built
> with CONFIG_I2C=n, have you tested this case?

No. Thanks for pointing this out, I'll fix it.

BR,
Anatolij
