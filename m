From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 28 Oct 2010 18:00:12 +0000
Subject: Re: [PATCH 1/2] viafb: General power management infrastructure
Message-Id: <20101028120012.4f62645f@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101028172301.BF7499D401B@zog.reactivated.net>
In-Reply-To: <20101028172301.BF7499D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 28 Oct 2010 18:23:01 +0100 (BST)
Daniel Drake <dsd@laptop.org> wrote:

> Jon: please review, I've added a mutex around viafb_pm_hooks and added
> an unregister function so that modules can be safely unloaded/reloaded

That makes obvious sense.  It looks good to me, feel free to add my
signoff to it if you want.

Thanks,

jon
