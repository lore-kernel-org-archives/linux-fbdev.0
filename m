From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 14 Oct 2015 11:31:52 +0000
Subject: Re: [PATCH RFC 0/2] simplefb: Add regulator handling support
Message-Id: <561E3D28.2090901@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444669458-5588-1-git-send-email-wens@csie.org>
 <561CAFE8.9080506@redhat.com> <20151014105556.GT14956@sirena.org.uk>
In-Reply-To: <20151014105556.GT14956@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 14-10-15 12:55, Mark Brown wrote:
> On Tue, Oct 13, 2015 at 09:16:56AM +0200, Hans de Goede wrote:
>> On 12-10-15 19:04, Chen-Yu Tsai wrote:
>
>>> Now the DT bindings don't support a list of regulators directly, so
>>> I'm working around it by having a "num-supplies" property to specify
>>> the number of supply properties to check, and name the actual supplies
>>> as "vinN-supply".
>
>> Hmm, I can see the need for a "supplies" property with a list of regulators
>> in other use-cases (e.g. the generic mmc-pwrseq driver) too. Now as discussed
>> we can simply do vin0-supply - vinN-supply properties and be done with it,
>> but maybe we need to actually add support for a generic "supplies" property ?
>
> I really don't like having unnamed supplies, or supplies with names that
> don't correspond to the schematic names for the physical supplies.  It
> makes it harder to go between the DT and the schematic and encourages
> bad practice on specific chip bindings which should be done properly
> since it's harder to tell if the binding is done correctly.

Ok.

> Adding something with the pattern of parallel arrays of phandles and
> names properties that got introduced after the regulator bindings were
> done also means we need to go and update every single binding using
> regulators to document the new properties which is going to be tedious
> and require constant policing for a while.  I'm also not a big fan of
> the pattern from a legibility point of view but that's a separate thing.

Oh no, I was not suggesting to have this replace how we currently do
things, I was merely suggesting allowing to have a supplies list property
for bindings where a list of (unnamed) supplies makes sense like simplefb.

I fully agree that we do not want to see matching a supplies-names prop,
if names are needed the old name-supply schema should be used just like
it is today.

>> And if not then maybe we need a few generic helper devm helper function which
>> takes a node, figures out how much vinN-supply properties there are and returns
>> a dynamically allocated array containing references to all the regulators, or
>> a PTR_ERR in case of err, at which point the caller is expected to fail the
>> probe so that any successfully acquired regulators are released.
>
> I can see it for this sort of simplefb thing but I'm not sure how we'd
> discourage drivers for specific hardware from also using the same helper
> which then makes it easy to get sloppy board DTs which I'd expect to
> lead to hassle down the road as drivers try to use their supplies and
> find that actual DTs have things that don't correspond to reality in
> them.  The nice thing about having drivers name the supplies they're
> expecting is that it makes describing the board as it really is much
> more the path of least resistance.

Ok, so as said I see some value in this for generic drivers like
simplefb, mmc-pwrseq, but also the generic ahci-platform, ohci-platform
and ehci-platform drivers, where often it is possible to use the generic
driver (together with a soc specific phy driver) without needing to
introduce new compatibles, as all we need is to specify a phy(s),
bunch of clocks, resets, etc. It would be good IMHO if we could specify
e.g. this is a generic ehci block, which needs this list of supplies
to be enabled (note typically the supplies are tied to the phy, so
maybe not the best example).

I like your idea in your other mail where you suggest to actually
use foo-supply and bar-supply names in the simplefb node, and then have
some code simple iterate over all the properties and check for *-supply
properties, so that the proper, schematic matching names can be used.

But surely if we go this way having a helper for this so that others
can re-use that likely not entirely trivial code is a good idea ?

One user which comes to mind immediately here is the generic mmc-pwrseq
driver.

I agree that we need to be careful to not use a helper like this too
much, but I do believe it will make sense to have it in some rare cases.
We can put a big warning in both the header declaring it and above
the implementation to use it scarcely.

Regards,

Hans
