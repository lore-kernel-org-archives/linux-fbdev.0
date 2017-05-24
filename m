From: "Tobin C. Harding" <me@tobin.cc>
Date: Wed, 24 May 2017 10:30:24 +0000
Subject: Re: staging: sm750fb: removed hungarian prfx and replace CamelCase variables
Message-Id: <20170524103024.GB2319@eros>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1495612454-10505-1-git-send-email-richaj@cdac.in>
In-Reply-To: <1495612454-10505-1-git-send-email-richaj@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richa Jha <richaj@cdac.in>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com, me@tobin.cc

On Wed, May 24, 2017 at 01:24:14PM +0530, Richa Jha wrote:
[snip]

Nice work so far. I'm having trouble with your patches. Here are a few
nitpicks to help you on your way.

There are 4 emails in the last few days with similar subjects but they
are not linked together. Also your email subject does not start with '[PATCH]',
I doubt they will be picked up without it. You should read
Documentation/process/submitting-patches.rst.

There are some other issues with your subject line and commit-log, if
you would like further comments please ask.

So for initial patch the subject is something like

[PATCH] staging: foo: Fix identifiers, hungarian notation and camel case

If you submit version 2, it will then be

[PATCH v2] staging: foo: Fix identifiers, hungarian notation and camel case

Good luck,
Tobin.
