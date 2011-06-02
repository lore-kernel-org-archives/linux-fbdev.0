From: Peter Jones <pjones@redhat.com>
Date: Thu, 02 Jun 2011 17:04:37 +0000
Subject: Re: [PATCH 0/4] efifb speedup and fixes
Message-Id: <4DE7C2A5.1090101@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1306418703.git.luto@mit.edu>
In-Reply-To: <cover.1306418703.git.luto@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

>> Andy Lutomirski (4):
>>   efifb: Enable write-combining
>>   efifb: Fix mismatched request/release_mem_region
>>   efifb: Fix an integer-to-pointer size warning
>>   efifb: Disallow manual bind and unbind
>>
> I've applied patches 1, 2, and 4 along with Peter's sign off. I've not
> added a stable cc since neither were specifically regressions, so I'll
> just let Greg naturally decide whether to take them or not.

Thanks, Paul.

-- 
        Peter
