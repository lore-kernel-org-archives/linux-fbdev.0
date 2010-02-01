From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 01 Feb 2010 22:46:33 +0000
Subject: Re: [PATCH/RFC 2.6.33-rc5 1/1] broadsheetfb: support storing
Message-Id: <20100201144633.e95da0ac.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1264395836-9892-1-git-send-email-jayakumar.lkml@gmail.com>
In-Reply-To: <1264395836-9892-1-git-send-email-jayakumar.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 2 Feb 2010 06:33:35 +0800
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> You are right, broadsheet is a framebuffer device. It is slightly
> different than a typical framebuffer controller that drives a normal
> TFT-LCD display. Most E-Ink display panels require a waveform in order
> to function. That is, in order to drive the state of a pixel to black,
> gray, or white, a specific waveform is utilized. Basically, that
> waveform represents the specific E-field wiggling needed to get the
> pixel to its optimal state given current temperature, and its previous
> state. TN/IPS-LCDs use a similar concept but the driving waveform is
> sufficiently simple that it is internalized in the TFT source/gate
> driver.
> 
> These E-Ink waveforms are specific to a production batch. That is, a
> batch of display films are produced, then they get characterized and a
> waveform is generated for that batch. Broadsheet, typically, is
> attached to its private SPI flash which is then flashed with this
> waveform.
> 
> Users won't be able to see the waveform and typically won't ever need
> to know about it. If however, the display panel attached to broadsheet
> is changed out, then they will need to update their waveform. That
> would typically be done at a factory or repair facility rather than by
> a user.

ah, I'd never have guessed, thanks.  I added that to the changelog ;)
