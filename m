From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 20 Dec 2009 13:33:45 +0000
Subject: Re: PROBLEM: loading viafb module turns screen to black on VN896
Message-Id: <4B2E27B9.3070507@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4B2E133B.9060502@web.de>
In-Reply-To: <4B2E133B.9060502@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Julian,

thanks for your feedback.

Julian Wollrath schrieb:
> Hi,
> 
> since I switched from 2.6.31.8 to 2.6.32.2 loading the viafb module
> turns the screen to black, there is no graphic output on the screen anymore.

Did you really use viafb before and if that's the case, how did you load 
the module? (including module parameters)
One change that even confused me is that after exposing the PCI stuff 
the module gets auto loaded and as viafb needs an insane amount of 
parameters to work correctly this lead to the effect you described as it 
didn't get its parameters. So is this problem caused by auto-loading?
If the above does not fit your situation, are you willing to do 
regression testing to figure out which patch to viafb exactly caused the 
behaviour you described?


Thanks,

Florian Tobias Schandinat
