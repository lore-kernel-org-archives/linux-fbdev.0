From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 23 Sep 2013 16:06:40 +0000
Subject: Re: [PATCH v3 1/2] video: ARM CLCD: Add DT support
Message-Id: <20130923160640.GT12758@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379351934-25415-1-git-send-email-pawel.moll@arm.com>
 <52376180.1090001@wwwdotorg.org> <1379435799.9205.16.camel@hornet>
 <5238CBE9.2060800@wwwdotorg.org> <1379522363.9244.12.camel@hornet>
 <52406646.709@wwwdotorg.org>
In-Reply-To: <52406646.709@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Sep 23, 2013 at 10:03:18AM -0600, Stephen Warren wrote:
> It sounds like you could just put LCDControl & 0x2e in the DT rather
> than using values such as 0x100..0x107, which don't appear to match the
> register format you mentioned above.

No.  Platforms which route the outputs to something like VGA or HDMI can
change the framebuffer format.  Your suggestions is far too restrictive.
