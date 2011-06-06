From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 06 Jun 2011 09:15:57 +0000
Subject: Re: [GIT PULL] fbdev fixes for 3.0-rc2
Message-Id: <20110606091556.GG26101@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110606033900.GF26101@linux-sh.org> <BANLkTik1nLG6f27JkR0kBvcJEoqUrq602A@mail.gmail.com>
In-Reply-To: <BANLkTik1nLG6f27JkR0kBvcJEoqUrq602A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 06, 2011 at 06:04:58PM +0900, Linus Torvalds wrote:
> On Mon, Jun 6, 2011 at 12:39 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> >
> > Bruno Pr??????????????????mont (1):
> > ?? ?? ??video: Fix use-after-free by vga16fb on rmmod
> 
> Do you even *look* at what you ask me to pull from you?
> 
> Spend a bit of effort in not sending obviously bogus and corrupted
> authorship patches. That one has Bruno's name correctly in the
> sign-off, but you've done something horrible to it in the authorship.
> 
That's how I got it from patchwork, so it looks like it was mangled
already on the way in. I assumed it was just my console that was screwing
it up, but it looks to be in a similar state in the list archives, too.

In any event, I've fixed it up and pushed out a cleaned up version, sorry
for the noise.
