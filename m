From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 20 Sep 2011 22:59:03 +0000
Subject: Re: [PATCH v2 0/4] sh_mobile_meram cleanups and fixes
Message-Id: <201109210059.04471.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316546490-4639-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1316546490-4639-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

On Tuesday 20 September 2011 21:21:26 Laurent Pinchart wrote:
> Hi,
> 
> Here's the second version of the sh_mobile_meram and cleanup fixes.
> Compared to v1, I've incorporated Damian's comments in the register
> definitions (first patch).
> 
> Laurent Pinchart (4):
>   fbdev: sh_mobile_meram: Replace hardcoded register values with macros
>   fbdev: sh_mobile_meram: Validate ICB configuration outside mutex
>   fbdev: sh_mobile_meram: Fix MExxCTL register save on runtime PM
>     suspend
>   fbdev: sh_mobile_meram: Remove unneeded sh_mobile_meram.h

This version conflicts with your fbdev-next branch in which you've already 
merged v1. Changes between v1 and v2 are cosmetic only, I'll send a patch 
later to be applied on top of your fbdev-next branch. You can thus ignore 
these patches.

-- 
Regards,

Laurent Pinchart
