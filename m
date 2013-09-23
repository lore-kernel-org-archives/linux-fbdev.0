From: Stephen Warren <swarren@wwwdotorg.org>
Date: Mon, 23 Sep 2013 16:30:15 +0000
Subject: Re: [PATCH v3 1/2] video: ARM CLCD: Add DT support
Message-Id: <52406C97.3010800@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379351934-25415-1-git-send-email-pawel.moll@arm.com>
 <52376180.1090001@wwwdotorg.org> <1379435799.9205.16.camel@hornet>
 <5238CBE9.2060800@wwwdotorg.org> <1379522363.9244.12.camel@hornet>
 <52406646.709@wwwdotorg.org> <20130923160640.GT12758@n2100.arm.linux.org.uk>
In-Reply-To: <20130923160640.GT12758@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 09/23/2013 10:06 AM, Russell King - ARM Linux wrote:
> On Mon, Sep 23, 2013 at 10:03:18AM -0600, Stephen Warren wrote:
>> It sounds like you could just put LCDControl & 0x2e in the DT rather
>> than using values such as 0x100..0x107, which don't appear to match the
>> register format you mentioned above.
> 
> No.  Platforms which route the outputs to something like VGA or HDMI can
> change the framebuffer format.  Your suggestions is far too restrictive.

Surely the DT should describe the HW setup only. Usually, a particular
HW setup can support multiple different framebuffer formats. Hence, the
DT wouldn't/shouldn't imply anything about the framebuffer format, but
simply which wires are connected to the LCD.
