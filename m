From: Daniel Drake <dsd@laptop.org>
Date: Tue, 21 Sep 2010 17:07:32 +0000
Subject: Re: [PATCH] viafb: Use proper register for bgcolor when doing MONO blits
Message-Id: <AANLkTi=rmBZP3=HUWML2fG76_bOjD5X4QQddDR0E4yVD@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921154604.2E3059D401B@zog.reactivated.net>
In-Reply-To: <20100921154604.2E3059D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 21 September 2010 18:00, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> Not really. For color blits it looks like we're doing the right thing here,
> at least it works on VX800 as I'd expect it (when I change the bg_color to
> red I get the characters with a red background, after applying your patch I
> get them with a black background). To me it looks like we should set this
> register for fillrect operations (as after your patch is applied I get a red
> backround for the space where no characters are).

Odd. That's exactly what we get on VX855 before the patch.

Jon, any comments?

Daniel
