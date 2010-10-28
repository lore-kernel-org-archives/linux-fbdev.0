From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 28 Oct 2010 22:04:29 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <20101028160429.308a385c@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 28 Oct 2010 22:54:23 +0100
Daniel Drake <dsd@laptop.org> wrote:

> So I don't really like any of these solutions. I think we should
> program this info from inside the kernel (like in my original patch,
> although I'm open for nicer ways to do the same thing)

Could you refresh my memory on that original patch?

I guess we could put something into the via-core initialization that
says:

	if (machine_is_olpc())
		turn_02c_to_gpio();

That covers only your case, and not that of anybody else who will have
wired up a board differently, but we can let them generalize it when
they run into trouble :)

Objections to that approach?

jon
