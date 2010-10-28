From: Daniel Drake <dsd@laptop.org>
Date: Thu, 28 Oct 2010 21:54:23 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <AANLkTikRjgMFHd+Ug5870dRW_uWTx7BhOUgfhdy=3MS2@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On 28 October 2010 19:51, Jonathan Corbet <corbet@lwn.net> wrote:
> I had always figured that the default settings for those ports would
> not suit everybody; it was just a matter of how they could be
> customized. =A0Options would seem to be:
>
> =A0- OLPC carries a small patch which configures the port properly.

I'm trying to get generic distro kernels to work, so not so keen on this one

> =A0- A set of configuration options is added allowing the port type to be
> =A0 set when the kernel is configured.

ditto

> =A0- The ports could be changed from the default configuration with a
> =A0 boot-time command-line option.
> That last option might be what works best for OLPC; those systems seem
> to need several lines of special boot options anyway. =A0It wouldn't be
> that hard to hack up...anybody got a better idea?

I'm hoping to get rid of that requirement for the reasons above, and
I'm wondering if we've already got that far (Florian said he had it
booting on his XO-1.5, although maybe he figured out the magic
parameters and is using them)...

So I don't really like any of these solutions. I think we should
program this info from inside the kernel (like in my original patch,
although I'm open for nicer ways to do the same thing)

Daniel
