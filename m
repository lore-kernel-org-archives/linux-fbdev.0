Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E75F6F076;
	Sun, 22 Sep 2024 02:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726971377; cv=none; b=eYl1W087mfhRsTN1RVnhbtbLvpTraeAyAwEbT6YeJBIcc3CYwjjwNjkjVSXM06xz44/Zeix7kzZbuC8GPGYiifuV90IoGIiR4FVqLszL/e/1h6D7zOtSAcr4JymCvTh7MGaNXiV/12T3ytYFNQtvFXhzHYAOdB1kWRnoARsR92A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726971377; c=relaxed/simple;
	bh=p3dOT3PBe6CvN1hB07Bxt6SIreaDWBgyB/iJcsSnDQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFscpD6ZygDNEO4Lu/A+sBb4ggMmaxOfdW2CydCQ7c9NwxkqYEs8sg5xfoWCn7vRygkuxkY0U8QeA+iI3Jz4aqjNengBuT1hyxfD6pGwaaf9tpGnc2lhs2Yi/8j2qEu5QiS73XeNzVUyFG+wRt0BzpYmaApK2lJtLq7C2JFaMWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayCHKsG8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayCHKsG8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726971375; x=1758507375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p3dOT3PBe6CvN1hB07Bxt6SIreaDWBgyB/iJcsSnDQs=;
  b=ayCHKsG8Ozk9grrrhbmNN74apKuH9gHbi3gMWXEDIi3kzeF06Ofs5gjS
   KSxvE0cP3oLTWCFULIqAm3PvKMajcaf2iIlQqIPY6KnwC1UQ1VEMcrxOg
   1RitTkZlaDnaz6PZJJjwlkcxIp03ys5NezYZnp4hPxgX34NAmM6aqgiZJ
   kbVkILLvsRJVscxV6Cd44ya9h+MTETbvHoAJfYIwMFTgz/ziiQ3fNnkJ/
   OACY6fFjaUjuQdCZedjW0+NQFA0M0jhH76UMrTw02wlnHrT+9zZ5K2NYd
   HRwJas9PlzcIqHgF2M9Xca00GBJk26WKE4nXrPOT/SMjidDR4p/pU62IN
   Q==;
X-CSE-ConnectionGUID: 2aExlym4Rxe3ugVTx/a96Q==
X-CSE-MsgGUID: /5gOuW3NSRyxVym0AJyf2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26129163"
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="26129163"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 19:16:14 -0700
X-CSE-ConnectionGUID: 3IuFOfnvQCW4cjKW132ggQ==
X-CSE-MsgGUID: cPQYkJ3lRHm6HNRoTY8eIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="70848038"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 21 Sep 2024 19:16:12 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssC8w-000Fxe-08;
	Sun, 22 Sep 2024 02:16:10 +0000
Date: Sun, 22 Sep 2024 10:15:39 +0800
From: kernel test robot <lkp@intel.com>
To: Fabricio Gasperin <fgasperin@lkcamp.dev>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] staging: sm750fb: Rename variable
 sm750_hw_cursor_setData2
Message-ID: <202409221050.Gx1KK7qA-lkp@intel.com>
References: <20240921152124.11560-1-fgasperin@lkcamp.dev>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240921152124.11560-1-fgasperin@lkcamp.dev>

Hi Fabricio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabricio-Gasperin/staging-sm750fb-Rename-variable-sm750_hw_cursor_setData2/20240921-232248
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20240921152124.11560-1-fgasperin%40lkcamp.dev
patch subject: [PATCH] staging: sm750fb: Rename variable sm750_hw_cursor_setData2
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20240922/202409221050.Gx1KK7qA-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240922/202409221050.Gx1KK7qA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409221050.Gx1KK7qA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/staging/sm750fb/sm750_cursor.c:6:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/staging/sm750fb/sm750_cursor.c:9:
   In file included from include/linux/fb.h:5:
   In file included from include/uapi/linux/fb.h:6:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:25:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/staging/sm750fb/sm750_cursor.c:9:
   In file included from include/linux/fb.h:5:
   In file included from include/uapi/linux/fb.h:6:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:25:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/staging/sm750fb/sm750_cursor.c:9:
   In file included from include/linux/fb.h:5:
   In file included from include/uapi/linux/fb.h:6:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:25:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/staging/sm750fb/sm750_cursor.c:134:6: warning: no previous prototype for function 'sm750_hw_cursor_setdata2' [-Wmissing-prototypes]
     134 | void sm750_hw_cursor_setdata2(struct lynx_cursor *cursor, u16 rop,
         |      ^
   drivers/staging/sm750fb/sm750_cursor.c:134:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     134 | void sm750_hw_cursor_setdata2(struct lynx_cursor *cursor, u16 rop,
         | ^
         | static 
   14 warnings generated.


vim +/sm750_hw_cursor_setdata2 +134 drivers/staging/sm750fb/sm750_cursor.c

   133	
 > 134	void sm750_hw_cursor_setdata2(struct lynx_cursor *cursor, u16 rop,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
