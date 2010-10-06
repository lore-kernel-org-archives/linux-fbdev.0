From: Jonathan Corbet <corbet@lwn.net>
Date: Wed, 06 Oct 2010 21:33:50 +0000
Subject: Re: [PATCH 0/4] initial suspend and resume support
Message-Id: <20101006153350.7e506f5f@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1285303222.git.FlorianSchandinat@gmx.de>
In-Reply-To: <cover.1285303222.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 24 Sep 2010 05:01:22 +0000
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> this little patch series finally adds basic suspend and resume support.
> The good thing is, that it nearly works.

I finally got around to taking a quick look at this.  It looks fine as
far as it goes, though I'd be tempted to take out the intermediate
steps and reduce the code churn a bit.

I need to dig out the more general suspend/resume stuff I have buried
in one of my trees, we'll need it at some point.  In the mean time, I
see no reason not to go ahead with this work.

Thanks,

jon
