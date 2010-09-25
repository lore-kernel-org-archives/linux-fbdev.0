From: Daniel Drake <dsd@laptop.org>
Date: Sat, 25 Sep 2010 20:23:36 +0000
Subject: Re: [PATCH] viafb: don't setup TMDS if it doesn't exist
Message-Id: <AANLkTi=P9Tt4P8w+yuOEJ3Kr2wuMoM8s_S9oL3w+6qbs@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100925195242.871699D401B@zog.reactivated.net>
In-Reply-To: <20100925195242.871699D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 25 September 2010 21:20, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> I wonder about that. Current linux-next with an unpatched viafb seems to
> work well on my XO 1.5. I guess I should notice a missing output?

Strange. I was testing with linus master. Nothing comes up on the
screen at all, and the display controller dies a scary death (screen
fades in and out as if the world is ending). Do you know which version
of the XO-1.5 you are working with?

Daniel
