From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 19 Oct 2015 07:59:25 +0000
Subject: Re: [PATCH RFC 0/2] simplefb: Add regulator handling support
Message-Id: <5624A2DD.4020101@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444669458-5588-1-git-send-email-wens@csie.org>
 <561CAFE8.9080506@redhat.com> <20151014105556.GT14956@sirena.org.uk>
 <561E3D28.2090901@redhat.com> <20151018195719.GC14956@sirena.org.uk>
In-Reply-To: <20151018195719.GC14956@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 18-10-15 21:57, Mark Brown wrote:
> On Wed, Oct 14, 2015 at 01:31:52PM +0200, Hans de Goede wrote:
>
>> I like your idea in your other mail where you suggest to actually
>> use foo-supply and bar-supply names in the simplefb node, and then have
>> some code simple iterate over all the properties and check for *-supply
>> properties, so that the proper, schematic matching names can be used.
>
>> But surely if we go this way having a helper for this so that others
>> can re-use that likely not entirely trivial code is a good idea ?
>
> Yeah.  It's trying to come up with a way to do this that is easy to
> avoid abuse that's tricky.
>
>> One user which comes to mind immediately here is the generic mmc-pwrseq
>> driver.
>
>> I agree that we need to be careful to not use a helper like this too
>> much, but I do believe it will make sense to have it in some rare cases.
>> We can put a big warning in both the header declaring it and above
>> the implementation to use it scarcely.
>
> I'd rather have something that was visible in the code, not everyone
> reads the documentation especially not subsystem maintainers reviewing
> drivers that use APIs they're not familiar with.

I'm afraid there is not really a good way to do this though, so a big fat
warning in the header declaring the function is really the bets we can
do IMHO.

Regards,

Hans
