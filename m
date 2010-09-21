From: Daniel Drake <dsd@laptop.org>
Date: Tue, 21 Sep 2010 17:15:55 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <AANLkTinmr3vo1EOvWR7JCcQaVmZcHYvW2YLfSkHsUy=A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 21 September 2010 18:15, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> Why? What happens if this patch is not applied?
> Please understand, that I, as a maintainer, try to avoid platform specific
> code as much as possible so a little explanation would be good.

Without the patch, the GPIO/I2C lines are not set up correctly so
we're unable to access the hardware connected there.

Daniel
