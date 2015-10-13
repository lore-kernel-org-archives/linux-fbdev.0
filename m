From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 13 Oct 2015 07:16:56 +0000
Subject: Re: [PATCH RFC 0/2] simplefb: Add regulator handling support
Message-Id: <561CAFE8.9080506@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444669458-5588-1-git-send-email-wens@csie.org>
In-Reply-To: <1444669458-5588-1-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 12-10-15 19:04, Chen-Yu Tsai wrote:
> Hi everyone,
>
> This series adds regulator claiming and enabling support for simplefb.
>
> Sometimes the simplefb display output path consits of external conversion
> chips and/or LCD drivers and backlights. These devices normally have
> GPIOs to turn them on and/or bring them out of reset, and regulators
> supplying power to them.
>
> While the kernel does not touch unclaimed GPIOs, the regulator core
> happily disables unused regulators. Thus we need simplefb to claim
> and enable the regulators used throughout the display pipeline.

Ack for doing something like this (adding regulator support) to simplefb,
it makes sense to have this.

> Now the DT bindings don't support a list of regulators directly, so
> I'm working around it by having a "num-supplies" property to specify
> the number of supply properties to check, and name the actual supplies
> as "vinN-supply".

Hmm, I can see the need for a "supplies" property with a list of regulators
in other use-cases (e.g. the generic mmc-pwrseq driver) too. Now as discussed
we can simply do vin0-supply - vinN-supply properties and be done with it,
but maybe we need to actually add support for a generic "supplies" property ?

And if not then maybe we need a few generic helper devm helper function which
takes a node, figures out how much vinN-supply properties there are and returns
a dynamically allocated array containing references to all the regulators, or
a PTR_ERR in case of err, at which point the caller is expected to fail the
probe so that any successfully acquired regulators are released.

Mark, what are your thoughts on this ?

Regards,

Hans
