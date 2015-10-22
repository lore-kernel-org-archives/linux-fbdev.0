From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Thu, 22 Oct 2015 19:30:30 +0000
Subject: Re: [PATCH v2 2/2] video: fbdev: pxafb: initial devicetree conversion
Message-Id: <87h9liya3t.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201510230211.r3WXXurc%fengguang.wu@intel.com>
In-Reply-To: <201510230211.r3WXXurc%fengguang.wu@intel.com> (kbuild test
	robot's message of "Fri, 23 Oct 2015 02:50:31 +0800")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Philipp Zabel <philipp.zabel@gmail.com>

kbuild test robot <lkp@intel.com> writes:

> Hi Robert,
>
> [auto build test ERROR on v4.3-rc5 -- if it's inappropriate base, please
> suggest rules for selecting the more suitable base]
...
>>> FATAL: drivers/video/fbdev/pxafb: struct of_device_id is not terminated with a NULL entry!

Ah silly me ... It probably deserves a v3 of the patch to add the forgotten :
        {},
at the end of the struct of_device_id ...

Cheers.

-- 
Robert
