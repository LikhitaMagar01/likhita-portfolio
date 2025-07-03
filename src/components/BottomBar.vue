<template>
  <nav class="fixed md:static bottom-4 left-1/2 md:left-auto transform md:transform-none -translate-x-1/2 md:translate-x-0 bg-gray-800 rounded-2xl shadow-lg px-6 py-2 flex space-x-6 items-center z-50 border border-gray-700">
    <button
      v-for="item in navItems"
      :key="item.label"
      class="flex flex-col items-center text-gray-400 hover:text-green-400 focus:outline-none"
      :class="{ 'text-green-400': selectedSection === item.target }"
      @click="$emit('section-change', item.target)"
    >
      <i :class="item.icon + ' text-xl mb-1'" />
      <span class="text-xs hidden sm:block">{{ item.label }}</span>
    </button>
  </nav>
</template>

<script setup lang="ts">
defineProps<{ selectedSection: string }>()
const emit = defineEmits(['section-change'])

const navItems = [
  { icon: 'fas fa-home', label: 'Home', target: 'home' },
  { icon: 'fas fa-user', label: 'About', target: 'about' },
  { icon: 'fas fa-graduation-cap', label: 'Education', target: 'education' },
  { icon: 'fas fa-briefcase', label: 'Experience', target: 'experience' },
  { icon: 'fas fa-cogs', label: 'Projects', target: 'projects' },
  { icon: 'fas fa-layer-group', label: 'Skills', target: 'skills' },
  { icon: 'fas fa-envelope', label: 'Contact', target: 'contact' },
];
</script>

<style scoped>
/* Add any custom styles if needed */
</style> 